require_relative 'base_service'

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
    wrap(result: true, instance: ad, errors: nil)
  rescue Sequel::NotNullConstraintViolation => e
    wrap(result: false, instance: ad, errors: e)
  rescue Sequel::MassAssignmentRestriction => e
    wrap(result: false, instance: ad, errors: e)
  end
end
