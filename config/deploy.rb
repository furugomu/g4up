require 'bundler/capistrano'

# rvm
#set :rvm_type, :user
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2@rails3.1'

#rbenv
set :default_environment, {
  'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/opt/bin:$PATH',
}

default_run_options[:pty] = true
set :application, "g4up"
set :repository,  "ssh://gitolite@precog.net/g4up"
set :deploy_to, "/var/rails/#{application}"
set :scm, :git
set :user, 'faerie'

role :web, "takamoriaiko.com"                          # Your HTTP server, Apache/etc
role :app, "takamoriaiko.com"                          # This may be the same as your `Web` server
role :db,  "takamoriaiko.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

require 'capistrano-unicorn'
