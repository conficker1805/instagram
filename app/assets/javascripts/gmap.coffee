@googleMap = {
  initialize: (locations = []) ->
    gmarkers = [];
    mapOptions = {
      zoom: 2,
      center: new google.maps.LatLng(1.3459084, 103.6855049),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    infowindow = new google.maps.InfoWindow()

    google.maps.event.addListener map, "click", (event) ->
      $('#location_lat').val(event.latLng.lat())
      $('#location_lng').val(event.latLng.lng())
      infowindow.close()

    createMarker = (location) ->
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(location[1], location[2]),
        map: map
      })

      google.maps.event.addListener(marker, 'click', () ->
        map.panTo marker.getPosition()
        map.setZoom 12
        infowindow.setContent location[0]
        infowindow.open map, marker
      )

    for i in [0...locations.length]
      createMarker(locations[i]);
}
