class ImageEntity
  include Virtus.model

  attribute :low_resolution, String
  attribute :thumbnail, String
  attribute :standard_resolution, String

  def low_resolution=(new_value)
    super new_value["url"]
  end

  def thumbnail=(new_value)
    super new_value["url"]
  end

  def standard_resolution=(new_value)
    super new_value["url"]
  end
end
