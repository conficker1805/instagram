module SocialHelper
  def google_infowindow(photo)
    "<p>#{ photo.location.name }</p><br><img src='#{photo.images.thumbnail}'/>"
  end

  def add_markers(markers, photo)
    markers << [google_infowindow(photo), photo.location.latitude, photo.location.longitude]
  end
end

