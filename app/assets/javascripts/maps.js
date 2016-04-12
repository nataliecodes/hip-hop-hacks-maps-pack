var map;
window.markerPositions = new Array;
var initMap = function() {
  if(!map) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 40.817, lng: -102.173},
      zoom: 4
    });
  }

  if(window.markerPositions.length > 0) {
    var bounds = new google.maps.LatLngBounds();
    window.markerPositions.forEach(function(position) {
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
    event.preventDefault();
    var songUrl = $(event.target).attr("href");
    $.ajax({
      url: '/maps',
      type: 'POST',
      dataType: 'JSON',
      data: {url: songUrl,
            query: "Brooklyn, NY"}
    }).done(function(response){
      window.markerPositions = response.marker_positions;
      initMap();
      $("#query-results-list").empty();
    }).fail(function(response){
      console.log("FAIL", response)
    });
  });
});