require 'dotenv/load'

require 'sinatra/base'
require 'json'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/json'
require 'sequel'
require 'dry-initializer'

require_relative '../serializers/ad_serializer'
require_relative '../config/sequal'
require_relative '../services/create_service'
require_relative '../models/ad'


module Service
  class API < Sinatra::Base
    get '/api/v1/ads' do
      page = (params[:page] || 1).to_i
      ads = Ad.order(:created_at).paginate(page, 5)
      result = AdSerializer.new(ads).serializable_hash.to_json
  
      return result
    end

    post '/api/v1/ads' do
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
end
