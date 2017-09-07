// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
// Montevideo latitude and longitude
var default_lat = -34.9011
var default_lng = -56.1645

$(document).ready(function() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: default_lat, lng: default_lng },
    zoom: 15
  });
});
