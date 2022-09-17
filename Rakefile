require 'sequel/db_tasks'
require 'dotenv/load' # require dotenv/load (dotenv gem) to get value of DATABASE_URL env variable inside .env file

Sequel::DbTasks.configure do |config|
  # config.database_url = ENV["DATABASE_URL"] # default value
  config.migrations_path = "db/migrate"     # default value
end

Sequel::DbTasks.load!