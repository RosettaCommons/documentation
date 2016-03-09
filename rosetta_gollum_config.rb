#!/usr/bin/env ruby

# This file contains configuration for the Gollum wiki itself.  If you are 
# running Gollum locally, use the `--config` flag to apply this configuration:
#
#     $ gollum --config rosetta_gollum_config.rb
#
# If you are running Gollum via Thin (a web server), this configuration should 
# be applied automatically.  Specifically, the `config.ru` imports this file 
# and should get loaded by Rack without any intervention on your part.

# Specify the wiki options.

WIKI_OPTIONS = {
  :universal_toc => false,
  :live_preview => false,
  :h1_title => true,
  :sidebar => :left,
  :mathjax => true,
  :css => true,
}

Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, WIKI_OPTIONS)

# Define a few useful macros.

class Gollum::Macro::MissingLinksPage < Gollum::Macro

  class MissingLink < StandardError
  end

  def render(fraction_num, num_fractions)
    @markup = Gollum::Markup.new @page
    @tags = Gollum::Filter::Tags.new(@markup)
    @tag_cache = {}

    # First, find all the broken links in the entire wiki and store them in a 
    # data structure called broken_links.  This structure maps page titles to 
    # lists of all the broken links on that page.

    html = ''
    broken_links = {}
    start_time = Time.now
    fraction_num = fraction_num.to_i
    num_fractions = num_fractions.to_i
    num_pages = @wiki.pages.size
    num_checked_pages = 0

    sorted_pages = @wiki.pages.sort{|a,b| a.title.downcase <=> b.title.downcase}

    sorted_pages.each_with_index do |page, i|
      # It takes long enough to find all the missing links in the wiki that 
      # Sinatra or Rack (I'm not sure which) gives up and sends an empty 
      # response before the search completes.  This made it necessary to split 
      # the search into several pages, which is what the logic below manages.

      next if i * num_fractions / num_pages + 1 != fraction_num

      broken_links[page] = []
      num_checked_pages += 1

      # The Tags filter doesn't really provide an API, so we have to cheat and 
      # reach into it to get access to the hash of all the tags in a page that 
      # it creates during extract().

      @tags.extract(page.text_data)
      @tags.instance_variable_get(:@map).each do |key, tag|

        # Check the tags for missing links.  Each function checks a different 
        # type of tag.  When a function is passed a tag of a type that it is 
        # not responsible for, it returns false and the tags is passed onto 
        # the next next function.  When a function is passed a tag of a type 
        # it is responsible for, it checks to make sure that link's target 
        # actually exists.  If it does, the function returns true to break the 
        # chain.  If it doesn't, the function raises a MissingLink error.  This 
        # error is caught immediately and causes the tag to be added to the 
        # list of broken links.

        begin 
          check_toc_tag(tag) || \
          check_include_tag(tag) || \
          check_link_tag(tag)
        rescue MissingLink
          broken_links[page] << tag
        end

      end
    end

    # Generate an HTML report of all the broken links discovered above.  Skip 
    # pages that don't have any broken links.

    html += "<h1>Missing Links (#{fraction_num}/#{num_fractions})</h1>\n"
    html += "<p>Showing missing links for #{num_checked_pages} of #{num_pages} pages in the wiki.</p>\n"

    broken_links.each do |page, missing_links|
      next if missing_links.empty?

      page_link = File.join(@wiki.base_path, page.url_path)
      page_title = page.title[0].upcase + page.title.slice(1..-1)

      html += "<a href=\"#{page_link}\">#{page_title}</a>\n"
      html += "<pre>\n"

      missing_links.each do |error_message|
        html += "[[#{error_message}]]\n"
      end

      html += "</pre>\n"
    end

    html
  end

  def check_toc_tag(tag)
    tag.strip == '_TOC_'
  end

  def check_include_tag(tag)
    return unless /^include:/.match(tag)

    page_name = tag[8..-1]
    resolved_page_name = ::File.expand_path(page_name, "/"+@markup.dir)

    if not @tags.send(:find_page_from_name, resolved_page_name)
      raise MissingLink
    end

    return true
  end

  def check_link_tag(tag)
    parts = tag.split('|')
    return if parts.size.zero?

    # If any part of the tag is a valid path, then the link is ok.  We have to 
    # check all the parts because we can't know a priori which part is supposed 
    # to be a path.  It's the first part for images but the second part for 
    # links.

    parts.each do |part|
      name = part.strip
      canonical_name = @page.class.cname(name)


      if name =~ /^https?:\/\//i
        return true
      elsif @tag_cache.key?(name)
        return @tag_cache[name]
      elsif @markup.find_file(name)
        @tag_cache[name] = true
        return true
      elsif @tags.send(:find_page_from_name, canonical_name)
        @tag_cache[name] = true
        return true
      else
        @tag_cache[name] = false
      end
    end

    # If the function gets this far, no valid links were found.

    raise MissingLink
  end

end

class Gollum::Macro::RawHtml < Gollum::Macro

  def render(*html)
      html.join(' ')
  end

end

class Gollum::Macro::FixedTableOfContents < Gollum::Macro

  # Render a table of contents from the perspective of the given page:
  #
  #     <<FixedTableOfContents('Home')>>
  #
  # In this example, the home page table of contents will be included on 
  # current page, whatever or wherever the current page is.

  def render(root)
    @markup = Gollum::Markup.new @page
    @tags = Gollum::Filter::Tags.new(@markup)
    @page = @tags.send(:find_page_from_name, root)
    process(@page.formatted_data)
    @toc
  end

  # The following functions were largely copied from Gollum.  The only 
  # difference is that I modified add_entry_to_toc() to produce absolute links 
  # rather than relative ones.

  def process(data)
    @doc               = Nokogiri::HTML::DocumentFragment.parse(data)
    @toc               = nil
    @anchor_names      = {}
    @current_ancestors = []

    @doc.css('h1,h2,h3,h4,h5,h6').each_with_index do |header, i|
      next if header.content.empty?
      # omit the first H1 (the page title) from the TOC if so configured
      next if (i == 0 && header.name =~ /[Hh]1/) && @markup.wiki && @markup.wiki.h1_title

      anchor_name = generate_anchor_name(header)
      
      add_anchor_to_header header, anchor_name
      add_entry_to_toc     header, anchor_name
    end

    @toc  = @toc.to_xml(@markup.to_xml_opts) if @toc != nil
    data  = @doc.to_xml(@markup.to_xml_opts)
 
    @markup.toc = @toc
    data.gsub("[[_TOC_]]") do
      @toc.nil? ? '' : @toc
    end
  end

  # Generates the anchor name from the given header element 
  # removing all non alphanumeric characters, replacing them
  # with single dashes.  
  #
  # Generates heading ancestry prefixing the headings
  # ancestor names to the generated name.
  #
  # Prefixes duplicate anchors with an index
  def generate_anchor_name(header)
    name = header.content
    level = header.name.gsub(/[hH]/, '').to_i

    # normalize the header name
    name.gsub!(/[^\d\w\u00C0-\u1FFF\u2C00-\uD7FF]/, "-")
    name.gsub!(/-+/, "-")
    name.gsub!(/^-/, "")
    name.gsub!(/-$/, "")
    name.downcase!

    @current_ancestors[level - 1] = name
    @current_ancestors = @current_ancestors.take(level)
    anchor_name = @current_ancestors.compact.join("_")

    # Ensure duplicate anchors have a unique prefix or the toc will break
    index = increment_anchor_index(anchor_name)
    anchor_name = "#{index}-#{anchor_name}" unless index.zero? # if the index is zero this name is unique

    anchor_name
  end

  def add_anchor_to_header(header, name)
    # Creates an anchor element with the given name and adds it before
    # the given header element.
    anchor_element = %Q(<a class="anchor" id="#{name}" href="##{name}"><i class="fa fa-link"></i></a>)
    header.children.before anchor_element # Add anchor element before the header
  end

  def add_entry_to_toc(header, name)
    # Adds an entry to the TOC for the given header.  The generated entry
    # is a link to the given anchor name
    @toc ||= Nokogiri::XML::DocumentFragment.parse('<div class="toc"><div class="toc-title">Table of Contents</div></div>')
    tail ||= @toc.child
    tail_level ||= 0

    level = header.name.gsub(/[hH]/, '').to_i

    while tail_level < level
      node = Nokogiri::XML::Node.new('ul', @doc)
      tail = tail.add_child(node)
      tail_level += 1
    end
    
    while tail_level > level
      tail = tail.parent
      tail_level -= 1
    end
    node = Nokogiri::XML::Node.new('li', @doc)
    # % -> %25 so anchors work on Firefox. See issue #475
    node.add_child(%Q{<a href="/#{@page.url_path}##{name}">#{header.content}</a>})
    tail.add_child(node)
  end

  # Increments the number of anchors with the given name
  # and returns the current index
  def increment_anchor_index(name)
    @anchor_names = {} if @anchor_names.nil?
    @anchor_names[name].nil? ? @anchor_names[name] = 0 : @anchor_names[name] += 1
  end

end

