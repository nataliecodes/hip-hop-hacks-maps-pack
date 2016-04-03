var map
window.markerPositions = new Array;
var initMap = function() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -30, lng: 150},
    zoom: 4
  });
  markerPositions.forEach(function(position) {
    new google.maps.Marker({
      map: map,
      position: position,
      title: "Test Marker"
    });
  });
}
