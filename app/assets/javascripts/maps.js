App.init.Map = function(pk) {
  L.mapbox.accessToken = pk;
  App.map = L.mapbox.map('map', 'mapbox.dark').setView([25, 5], 2);

  App.geoLogCluster = new L.MarkerClusterGroup();

  App.map.addLayer(App.geoLogCluster);

  App.addGeoLogPoint = function(lat, lng, title) {
    var marker = L.marker(new L.LatLng(lat, lng), {
      icon: L.mapbox.marker.icon({'marker-symbol': 'post', 'marker-color': '0044FF'}),
      title: title
    });
    marker.bindPopup(title);
    App.geoLogCluster.addLayer(marker);
  };

}
