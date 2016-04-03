var map;
window.markerPositions = new Array;
var initMap = function() {
  if(!map) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -30, lng: 150},
      zoom: 8
    });
  }
}
