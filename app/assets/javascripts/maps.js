App.init.Map = function(pk) {
  L.mapbox.accessToken = pk;
  App.map = L.mapbox.map('map', 'mapbox.dark').setView([25, 5], 2);
}
