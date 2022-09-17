require 'jsonapi/serializer'

class AdSerializer
  include JSONAPI::Serializer

  attributes :title,
             :description,
             :city,
             :lat,
             :lon

  set_id :user_id
end
