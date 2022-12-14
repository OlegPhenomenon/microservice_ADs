require_relative '../initialize'

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
      service = CreateService.new(payload)
      result = service.call

      if result.result?
        result = AdSerializer.new(result.instance).serializable_hash.to_json

        status 201
        result
      else
        status 422
        json error: result.errors
      end
    end
  end
end
