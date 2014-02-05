#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'gollum/app'
require 'omnigollum'
require 'omniauth/strategies/github'
require 'omniauth/strategies/github_team_member'

# need to set this or else it uses http (no 's'), which causes github to give a bad URL error
#OmniAuth.config.full_host = 'https://www.rosettacommons.org/docs'

options = {
  # OmniAuth::Builder block is passed as a proc
  :providers => Proc.new do
    provider :githubteammember, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], :scope => 'repo,user'
  end,
  :dummy_auth => false,
  :route_prefix => '/__omnigollum__'
}

# :omnigollum options *must* be set before the Omnigollum extension is registered
gollum_path = File.expand_path(File.dirname(__FILE__))
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, {:base_path => "/docs", :universal_toc => false})
Precious::App.set(:omnigollum, options)

options[:authorized_users] = []

Precious::App.register Omnigollum::Sinatra

map '/docs' do
  run Precious::App
end

