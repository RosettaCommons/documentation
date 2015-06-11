#!/usr/bin/env ruby

# Specify the wiki options.
wiki_options = {
  :live_preview => false,
  :universal_toc => false,
  :sidebar => :left
}

Precious::App.set(:wiki_options, wiki_options)

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

    if not find_page_from_name(resolved_page_name)
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

