class PhotosController < ApplicationController
  def index
    location = Location.create_with(location_params)

    if location.valid?
      @photos = InstagramConnect::Photos.near(location)
    else
      flash[:alert] = location.errors.first.join(" ")
      redirect_to root_path(location: location_params)
    end
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude, :distance)
  end
end
