class Gollum::Macro::FindRedLinks < Gollum::Macro
  def render(*args)

    if @wiki.pages.size > 0
      '<ul id="pages">' + @wiki.pages.map { |p| "<li>#{p.name}</li>" }.join + '</ul>'
    end

      # broken_links = {}
      #
      # for each page in the wiki:
      #     tags = Filter::Tags.new()
      #     tags.extract(page.data)
      #
      #     for tag in tags.map:
      #         @wiki_or_markup.find_file(tag)
      #
      #         if not found:
      #             broken_links[page.path].append(tag)
      #
      # html = ''
      #
      # for page, red_links in sorted(broken_links):
      #     html += "<h2>#{page}</h2>\n"
      #     html += "<ul>\n"
      #
      #     for link in red_links:
      #         page += "<li>#{link}</li>"
      #
      #     html += "</ul>"
      #
      # return html

    args.map { |a| "@#{a}@" }.join("\n")
  end
end


class Gollum::Macro::LinkDemos < Gollum::Macro
  def render(demos_root)
    page_dir = File.dirname(@page.path)
    demos_dir = File.join(page_dir, demos_root)
    abs_page_dir = File.join(@wiki.path, page_dir)
    abs_demos_dir = File.join(abs_page_dir, demos_root)
    abs_demos_glob = File.join(abs_demos_dir, '*/')

    html = "<ul>\n"

    Dir[abs_demos_glob].sort.each do |abs_demo_dir|
        demo_name = File.basename(abs_demo_dir)
        demo_readme = File.join(demos_dir, demo_name, 'README')
        abs_readme_glob = File.join(abs_demo_dir, '[Rr][Ee][Aa][Dd][Mm][Ee]*')
        readme_exists = Dir[abs_readme_glob].select{|x|
            Gollum::Page.parse_filename(x) != []
        }.any?

        html += %{<li><a class="internal #{readme_exists ? 'present' : 'absent'}" href="#{demo_readme}">#{demo_name}</a></li>\n}
    end

    html += "</ul>"
  end
end

class Gollum::Macro::LinkDemosViaSlowMarkup < Gollum::Macro
  def render(demos_root)
    links = []

    page_dir = File.dirname(@page.path)
    demos_dir = File.join(page_dir, demos_root)
    demos_glob = File.join(@wiki.path, page_dir, demos_root, '*/')

    Dir[demos_glob].sort.each do |demo_dir|
      demo_name = File.basename(demo_dir)
      demo_readme = File.join(demos_dir, demo_name, 'readme')
      links << "- [[#{demo_name}|#{demo_readme}]]"
    end

    # Gollum will spend a long time doing a breadth-first search for files if I
    # have it format the links for me.  It would be significantly faster if I
    # formatted the HTML myself, and but then my formatting my not be in sync
    # with Gollum's.  Perhaps I can find the specific method Gollum uses to 
    # format links.

    markup = Gollum::Markup.new @page
    markup.render_default(links.join("\n"))
  end
end


