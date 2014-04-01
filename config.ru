#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'gollum/app'
require 'omnigollum'
require 'omniauth/strategies/github'
require 'omniauth/strategies/github_team_member'

Gollum::Hook.register(:post_commit, :hook_id) do |committer, sha1|
  committer.wiki.repo.git.pull
  committer.wiki.repo.git.push
end

map '/docs' do
  host = 'https://www.rosettacommons.org'
  # need to set this or else it uses http (no 's'), which causes github to give a bad URL error
  OmniAuth.config.full_host = host
  
  options = {
    # OmniAuth::Builder block is passed as a proc
    :providers => Proc.new do
      provider :githubteammember, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], :scope => 'repo,user'
    end,
    :dummy_auth => false,
    :route_prefix => '/__omnigollum__',
    :base_path => '/docs',
  }

   
  # :omnigollum options *must* be set before the Omnigollum extension is registered
  gollum_path = File.expand_path(File.dirname(__FILE__))
  Precious::App.set(:gollum_path, gollum_path)
  Precious::App.set(:default_markup, :markdown)
  Precious::App.set(:wiki_options, {:universal_toc => false, :live_preview => false})
  Precious::App.set(:omnigollum, options)

  Precious::App.set :protection, :origin_whitelist => [host]
  
  options[:authorized_users] = []

  
  Precious::App.register Omnigollum::Sinatra
#  Precious::App.set(:sessions, { :key => 'rack_session' })
  Precious::App.settings.mustache[:templates] = gollum_path + '/templates'

  run Precious::App
end

