App.init.Map = function(pk) {

  L.mapbox.accessToken = pk;

  const MAX_MARKERS = 50000

  var map = App.map = L.mapbox.map('map', 'mapbox.dark', {
    maxZoom: 10,
    minZoom: 2,
  }).setView([41.4, 11.1], 2);

  var clusterGroup = App.clusterGroup = new L.MarkerClusterGroup({
    showCoverageOnHover: false,
    animateAddingMarkers: true,
    maxClusterRadius: 40,
  });

  var markerList = App.markerList = [];

  map.addLayer(clusterGroup);

  App.addClusterPoint = function(lat, lng, title) {
    var marker = L.marker(new L.LatLng(lat, lng), {
      icon: L.divIcon({ iconSize: [24, 24], className: 'marker-icon' }),
    });

    markerList.push(marker);
    var markersToRemove = markerList.slice(0, -MAX_MARKERS)
    markerList = markerList.slice(-MAX_MARKERS)

    clusterGroup.addLayer(marker);
    clusterGroup.removeLayers(markersToRemove);
  };

}
