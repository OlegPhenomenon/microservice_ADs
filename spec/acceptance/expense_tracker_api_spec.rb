require 'rack/test'
require 'json'
require_relative '../../app/api'
require_relative '../support/db'
require 'rack/test'

module Service
  RSpec.describe 'Ad microservice API', :db do
    include Rack::Test::Methods

    def app
      Service::API.new
    end

    it 'should return list of ads' do
      get '/api/v1/ads'

      expect(last_response.status).to eq(200)
    end

    it 'shoult add ad to list' do
      p Ad.count

      ad = {
            title: "Abalbiska12",
            description: "Ad description 1",
            city: "City 777",
            user_id: 1
           }

      post '/api/v1/ads', JSON.generate(ad)

      p Ad.count

      expect(last_response.status).to eq(200)
    end
  end
end
