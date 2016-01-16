class InstagramPhotoEntity
  include Virtus.model

  attribute :location, LocationEntity
  attribute :images, ImageEntity
end
