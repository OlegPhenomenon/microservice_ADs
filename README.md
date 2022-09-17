# Ad microservice

Create dev DB: `bundle exec sequel -m ./db/migrations sqlite://db/development.db --echo`
Create test DB: `bundle exec sequel -m ./db/migrations sqlite://db/test.db --echo`
Run application `bundle exec rerun rackup`
Run tests `bundle exec rspec`
