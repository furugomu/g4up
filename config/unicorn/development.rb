# -*- encoding: utf-8 -*-

require 'pathname'
root = Pathname.new(__FILE__).dirname.join('..', '..').realpath

listen root.join('tmp', 'sockets', 'unicorn.sock').to_s
worker_processes 2

working_directory root.to_s
pid root.join('tmp', 'pids', 'unicorn.pid').to_s
#stderr_path root.join('log', 'unicorn.stderr.log').to_s
#stdout_path root.join('log', 'unicorn.stdout.log').to_s

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
