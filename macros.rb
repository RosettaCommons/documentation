class Gollum::Macro::MissingLinksPage < Gollum::Macro

  class MissingLink < StandardError
  end

  def render(page_num, num_pages)
    @markup = Gollum::Markup.new @page
    @tags = Gollum::Filter::Tags.new(@markup)
    @tag_cache = {}

    # First, find all the broken links in the entire wiki and store them in a 
    # data structure called broken_links.  This structure maps page titles to 
    # lists of all the broken links on that page.

    html = ''
    broken_links = {}
    start_time = Time.now

    i = 1
    @wiki.pages.each do |page|
      @tags.extract(page.text_data)

      broken_links[page.title] = []

      # The Tags filter doesn't really provide an API, so we have to cheat and 
      # reach into it to get access to the hash of all the tags in a page that 
      # it creates during extract().

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
          broken_links[page.title] << tag
        end

      end

      # The web browser gives up and resets the connection before all the 
      # missing links can be found, so limit the search to a few seconds.

      elapsed_time = Time.now - start_time
      puts "#{i}/#{@wiki.pages.size}\t#{elapsed_time}"
      i += 1
      #if elapsed_time > 29
      #  html += "<p>The search for missing links was aborted after <b>%.1f seconds</b>.  Fix some links and reload to get more.</p>" % elapsed_time
      #  break
      #end
    end

    # Generate an HTML report of all the broken links discovered above.  Skip 
    # pages that don't have any broken links.

    html += "<h1>Missing Links (#{page_num}/#{num_pages})</h1>\n"

    broken_links.each do |page_title, missing_links|
      next if missing_links.empty?

      html += "#{page_title}\n"
      #html += "<ul>\n"
      html += "<pre>\n"

      missing_links.each do |error_message|
        #html += "<li>[[#{error_message}]]</li>\n"
        html += "[[#{error_message}]]\n"
      end

      #html += "</ul>\n"
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
