# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "sinatra"
gem "puma"
gem 'jsonapi-serializer'
gem 'sequel'
gem 'pg', '>= 0.18', '< 2.0'
gem 'sinatra-contrib'
gem 'dry-initializer', '~> 3.0.3'
gem 'dotenv'

group :development, :test do
  gem "rerun"
end
