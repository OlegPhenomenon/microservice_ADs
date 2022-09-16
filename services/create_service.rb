require_relative 'base_service'

module Ads
  class CreateService < BaseService
    param :title
    param :description
    param :city
    param :user_id

    def initialize(payload)
      @ad = payload
    end

    def call
      ad = Ad.new(@ad.to_h)
      ad.save
      wrap([true, ad, nil])
      
    rescue Sequel::NotNullConstraintViolation => e
      wrap([false, ad, e])
    rescue Sequel::MassAssignmentRestriction => e
      wrap([false, ad, e])
    end
  end
end
