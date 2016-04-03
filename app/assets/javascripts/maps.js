var map;
window.markerPositions = new Array;
var initMap = function() {
  if(!map) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -30, lng: 150},
      zoom: 8
    });
  }

  if(markerPositions.length > 0) {
    var bounds = new google.maps.LatLngBounds();
    markerPositions.forEach(function(position) {
      var coords = new google.maps.LatLng(position.lat, position.lng)
      new google.maps.Marker({
        map: map,
        position: position,
        title: "Test Marker"
      });
      bounds.extend(coords);
    });
    map.fitBounds(bounds);
  }
};

$(document).ready(function(){
  $("#layout-container").on("click", ".query-result", function(event){
    console.log(event);
    event.preventDefault();
  });
});