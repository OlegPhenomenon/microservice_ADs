# frozen_string_literal: true

# bundle exec rerun ruby app.rb
require 'dotenv/load'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/json'
require 'sequel'
require 'json'
require 'dry-initializer'

require_relative 'serializers/ad_serializer'
require_relative 'db_init'
require_relative 'services/create_service'
require_relative 'models/ad'

Sequel.application_timezone = :local

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/ads' do
    page = params[:page].to_i || 1
    ads = Ad.order(:created_at).paginate(page, 2)
    result = AdSerializer.new(ads).serializable_hash.to_json

    return result
  end

  post '/ads' do
    payload = JSON.parse(request.body.read).symbolize_keys
    service = Ads::CreateService.new(payload)
    result = service.call

    if result.result
      result = AdSerializer.new(result.instance).serializable_hash.to_json
      result
    else
      status 422
      json error: result.errors
    end
  end
end
