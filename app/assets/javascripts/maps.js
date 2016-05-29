var map;
$(document).ready(function() {
  L.mapbox.accessToken = '';
  map = L.mapbox.map('map', 'mapbox.dark').setView([25, 5], 2);
});

