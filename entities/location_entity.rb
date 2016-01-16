class LocationEntity
  include Virtus.model

  attribute :id, Integer
  attribute :name, String
  attribute :latitude, Float
  attribute :longitude, Float
end
