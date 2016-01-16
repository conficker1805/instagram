class Location
  include ActiveModel::Validations

  attr_accessor :latitude, :longitude, :distance

  validates :latitude,  presence: true
  validates :longitude, presence: true
  validates :latitude,  numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :distance,  numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, if: 'distance.present?'

  def self.create_with(permitted_params)
    location = Location.new
    permitted_params.each do |key, value|
      location.instance_variable_set("@#{ key }".to_sym, value)
    end

    location
  end
end
