require_relative '../../app/api'
require 'rack/test'
require_relative '../support/db'
require 'json'

module Service
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new
    end

    describe 'POST /api/v1/ads', :db do
      context 'when ads is successfully recorded' do
        let(:ad) do
          {
            'title' => 'Abalbiska12',
            'description' => 'Ad description 1',
            'city' => 'City 777',
            'user_id' => '1'
          }
        end

        it 'return with a 200 OK' do
          post '/api/v1/ads', JSON.generate(ad)
          expect(last_response.status).to be(201)
        end

        it 'returns the id of record' do
          expect(Ad.count).to eq(0)

          post '/api/v1/ads', JSON.generate(ad)
          expect(Ad.count).to eq(1)
          expect(Ad.last).to a_hash_including(user_id: 1)
          expect(Ad.last).to a_hash_including(title: 'Abalbiska12')
        end
      end

      context 'when ads record is failed' do
        let(:ad) do
          {
            'title' => 'Abalbiska12',
            'description' => 'Ad description 1',
            'city' => 'City 777'
          }
        end

        it 'returns an error message' do
          expect(Ad.count).to eq(0)

          post '/api/v1/ads', JSON.generate(ad)

          expect(Ad.count).to eq(0)
          response = JSON.parse(last_response.body, { symbolize_names: true })
          expect(response).to a_hash_including(error: 'SQLite3::ConstraintException: NOT NULL constraint failed: ads.user_id')
        end

        it 'return with a 422 Unprocessable Entity' do
          expect(Ad.count).to eq(0)

          post '/api/v1/ads', JSON.generate(ad)

          expect(Ad.count).to eq(0)
          expect(last_response.status).to eq(422)
        end
      end
    end

    describe 'GET /api/v1/ads' do
      let(:ad) do
        {
          'title' => 'Abalbiska12',
          'description' => 'Ad description 1',
          'city' => 'City 777',
          'user_id' => '1'
        }
      end

      context 'when ads is successfully returned' do
        it 'shoud return list of ads' do
          post '/api/v1/ads', JSON.generate(ad)

          get '/api/v1/ads'

          parsed = JSON.parse(last_response.body, { symbolize_names: true })
          expect(parsed[:data][0][:attributes]).to a_hash_including(title: 'Abalbiska12')
        end

        it 'should return 200 OK' do
          get '/api/v1/ads'
          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
