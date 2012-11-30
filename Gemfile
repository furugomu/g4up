# -*- mode: ruby; encoding: UTF-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.2.2'
gem 'sqlite3', group: [:test, :development]
gem 'pg', group: :production
gem 'paperclip', '2.4.5'
gem 'aws-s3'
gem 'acts-as-taggable-on'
gem 'kaminari'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>=1.0.3'
  gem 'therubyracer'
end

gem 'jquery-rails'

# Use unicorn as the web server
#gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails'
group :test do
  gem 'factory_girl_rails'
end
