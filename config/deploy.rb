require 'bundler/capistrano'

# rvm
set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2@rails3.1'

default_run_options[:pty] = true
set :application, "g4up"
set :repository,  "ssh://gitolite@precog.net/g4up"
set :deploy_to, "/var/rails/#{application}"
set :scm, :git
set :user, 'faerie'

role :web, "precog.net"                          # Your HTTP server, Apache/etc
role :app, "precog.net"                          # This may be the same as your `Web` server
role :db,  "precog.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  after "deploy:symlink", "deploy:s3config"
  namespace :s3config do
    desc "link s3.yaml from shared"
    run "ln -s #{shared_path}/config/s3.yaml #{current_path}/config/s3.yaml"
  end
end
