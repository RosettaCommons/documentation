#!/usr/bin/env ruby

# Specify the wiki options.
wiki_options = {
  :live_preview => false,
  :universal_toc => false,
  :sidebar => :left
}

Precious::App.set(:wiki_options, wiki_options)

