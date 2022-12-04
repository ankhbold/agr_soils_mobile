import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GooMap extends StatefulWidget {
  //GooMap({Key key}) : super(key: key);

  @override
  _GooMapState createState() => _GooMapState();
}

class _GooMapState extends State<GooMap> {
  // Location
  late LocationData _locationData;

  // Maps
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  late GoogleMapController _googleMapController;
  late BitmapDescriptor _markerIcon;
  List<LatLng> polygonLatLngs = <LatLng>[];

  //ids
  int _polygonIdCounter = 1;
  int _markerIdCounter = 1;

  // Type controllers
  bool _isPolygon = false; //Default
  bool _isMarker = true;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
  }

  // This function is to change the marker icon
  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/farm.png');
  }

  // Draw Polygon to the map
  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs,
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    ));
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  // Start the map with this marker setted up
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(-20.131886, -47.484488),
          infoWindow:
              InfoWindow(title: 'Roça', snippet: 'Um bom lugar para estar'),
          //icon: _markerIcon,
        ),
      );
    });
  }

  Widget _fabPolygon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            //Remove the last point setted at the polygon
            setState(() {
              polygonLatLngs.removeLast();
            });
          },
          icon: Icon(Icons.undo),
          label: Text('Undo point'),
          backgroundColor: Colors.orange,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            polygonLatLngs.length > 0 && _isPolygon ? _fabPolygon() : null,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(50.054818, 105.820441),
                zoom: 16,
              ),
              mapType: MapType.satellite,
              markers: _markers,
              polygons: _polygons,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onTap: (point) {
                if (_isPolygon) {
                  setState(() {
                    polygonLatLngs.add(point);
                    _setPolygon();
                  });
                } else if (_isMarker) {
                  setState(() {
                    _polygons.clear();
                    _markers.clear();
                    _setMarkers(point);
                  });
                }
              },
            ),
            Positioned(
              bottom: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 110,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _isPolygon = true;
                        _isMarker = false;
                      },
                      child: Text(
                        'Polygon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _isPolygon = false;
                      _isMarker = true;
                    },
                    child: Text('x'),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
