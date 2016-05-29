App.init.Map = function(pk) {

  L.mapbox.accessToken = pk;

  App.map = L.mapbox.map('map', 'mapbox.dark', {
    maxZoom: 10,
    minZoom: 2,
  }).setView([41.4, 11.1], 2);

  App.geoLogCluster = new L.MarkerClusterGroup({
    showCoverageOnHover: false,
    animateAddingMarkers: true,
    maxClusterRadius: 40,
  });

  App.map.addLayer(App.geoLogCluster);

  App.addGeoLogPoint = function(lat, lng, title) {
    var marker = L.marker(new L.LatLng(lat, lng), {
      icon: L.divIcon({ iconSize: [24, 24], className: 'marker-icon' }),
    });

    App.geoLogCluster.addLayer(marker);
  };

}
