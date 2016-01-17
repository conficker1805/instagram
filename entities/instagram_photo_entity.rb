class InstagramPhotoEntity
  include Virtus.model

  attribute :location, LocationEntity
  attribute :images, ImageEntity
  attribute :link, String
end
