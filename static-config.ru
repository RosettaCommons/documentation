#!/usr/bin/env ruby

# This file contains configuration that is specific to the web server hosting 
# the Gollum wiki.  Specifically, the setup we have on our live website is a 
# Thin server running Gollum, which is built on the Sinatra & Rack frameworks.  
# Configuration for gollum itself is written in `rosetta_gollum_config.rb` and 
# is simply imported here.
#
# To launch the web server, you first need to use Bundler to install all the 
# required third-party packages.  The Gemfile included in this repository 
# specifies which versions of which packages are required.
#
#     $ bundle install
#
# You have to use Bundler to launch the web server, so that it can setup an 
# environment in which all the right versions of all the right packages are 
# present.  Again, the web server is Thin:
#
#     $ bundle exec thin start
#
# By default, Thin listens on localhost on port 3000.  Furthermore, this 
# configuration file specifies that all the wiki pages should be served out of 
# the /docs/wiki directory.  So you have to direct your browser to the 
# following address to see the wiki:
#
#     http://localhost:3000/docs/wiki/

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'gollum/app'

# Import the general Gollum configuration from a file devoted to that.

require_relative './rosetta_gollum_config.rb'


map '/docs/wiki' do
  gollum_path = File.expand_path(File.dirname(__FILE__))
  Precious::App.set(:gollum_path, gollum_path)

  Precious::App.settings.mustache[:templates] = gollum_path + '/templates'
  Precious::App.set(:wiki_options, {:allow_editing => false})
 
  run Precious::App
end

