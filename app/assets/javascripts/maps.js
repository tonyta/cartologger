App.init.Map = function(pk) {

  L.mapbox.accessToken = pk;

  App.map = map = L.mapbox.map('map', 'mapbox.dark', {
    maxZoom: 10,
    minZoom: 2,
  }).setView([41.4, 11.1], 2);

  var clusterGroup = new L.MarkerClusterGroup({
    showCoverageOnHover: false,
    animateAddingMarkers: true,
    maxClusterRadius: 40,
  });

  map.addLayer(clusterGroup);

  App.addClusterPoint = function(lat, lng, title) {
    var marker = L.marker(new L.LatLng(lat, lng), {
      icon: L.divIcon({ iconSize: [24, 24], className: 'marker-icon' }),
    });

    clusterGroup.addLayer(marker);
  };

}
