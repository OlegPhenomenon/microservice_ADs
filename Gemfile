# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dotenv'
gem 'dry-initializer', '~> 3.0.3'
gem 'jsonapi-serializer'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'sequel'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sqlite3'

group :development, :test do
  gem 'rerun'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
end
