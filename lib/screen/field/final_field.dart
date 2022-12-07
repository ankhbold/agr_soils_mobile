import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/location/location.dart';
import 'package:mvvm/screen/field/field_panel.dart';
import 'package:mvvm/screen/field/floating_fields.dart';
import 'package:mvvm/screen/field/floating_items.dart';
import 'package:mvvm/screen/field/panel_widget.dart';
import 'package:mvvm/widget/custom_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

bool _isPolygon = false; //Default
bool _isMarker = true;
bool note = true;
//------
bool click = true;
//------
bool clicks = true;
//-------
int clicked = 0;

class FinalField extends StatefulWidget {
  const FinalField({super.key});

  @override
  State<FinalField> createState() => _FinalFieldState();
}

class _FinalFieldState extends State<FinalField> {
  bool isFirstWidgetVisible = true;
  bool isSecondWidgetVisible = false;
  bool isThirdWidgetVisible = false;

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _markerIdCounter = 1;
  final MapType _currentMapType = MapType.hybrid;

  late GoogleMapController _mapController;

  LatLng firstLocation = const LatLng(50.054818, 105.820441);
  static double fabHeightClosed = 95.0;
  double fabHeight = fabHeightClosed;
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: FloatingFab(),
    ),
    Tab(
      child: FloatingFields(),
    ),
  ];
  Future<Null> _refresh() async {
    click;
    // You can do part here what you want to refresh
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;

    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;

    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.1;

    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.65;

    return Scaffold(
      floatingActionButton: _isPolygon
          ? polygonLatLngs.length > 0 && _isPolygon
              ? _fabPolygon()
              : null
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.small(
                          backgroundColor: Color.fromARGB(255, 239, 239, 239)
                              .withOpacity(0.85),
                          child: Icon(
                            Icons.note_add,
                            color: AppColors.Green,
                          ),
                          onPressed: () {
                            setState(() {
                              note = !note;
                            });
                          }),
                      FloatingActionButton.small(
                        backgroundColor:
                            const Color.fromARGB(255, 239, 239, 239)
                                .withOpacity(0.85),
                        elevation: 0,
                        onPressed: () {
                          _determinePosition().then(
                            (value) async {
                              print("my current location"); //wsg84
                              print("${value.latitude} ${value.longitude}");
                              CameraPosition cameraPosition = CameraPosition(
                                  zoom: 17,
                                  target:
                                      LatLng(value.latitude, value.longitude));
                              final GoogleMapController controller =
                                  _mapController;

                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      cameraPosition));
                              setState(() {});
                            },
                          );
                        },
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.Green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      extendBodyBehindAppBar: true,
      appBar: customAppBar(context),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              polygons: _polygons,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: firstLocation,
                zoom: 14.5,
              ),
              mapType: _currentMapType,
              onMapCreated: (controller) {
                _mapController = controller;
                setState(() {
                  _markers.add(
                    Marker(
                      markerId: MarkerId('0'),
                      position: LatLng(-20.131886, -47.484488),
                      infoWindow: InfoWindow(
                          title: 'Roça', snippet: 'Um bom lugar para estar'),
                    ),
                  );
                });
              },
              onTap: (point) {
                setState(() {
                  if (_isPolygon) {
                    setState(() {
                      polygonLatLngs.add(point);
                      _setPolygon(point);

                      _markers.clear();
                    });
                  } else if (_isMarker) {
                    setState(() {
                      _markers.add(
                        Marker(
                          markerId: MarkerId('0'),
                          position: LatLng(-20.131886, -47.484488),
                          infoWindow: InfoWindow(
                              title: 'Roça',
                              snippet: 'Um bom lugar para estar'),
                        ),
                      );
                      _markers.clear();
                      _polygons.clear();
                      _setMarkers(point);
                    });
                  }
                });
              },
            ),
          ),
          Offstage(
            offstage: !isFirstWidgetVisible,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightOpened,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => PanelWidget(
                controller: controller,
              ),
              onPanelSlide: (position) => setState(
                () {
                  final panelMaxScrollExtent =
                      panelHeightOpened - panelHeightClosed;
                  fabHeight =
                      position * panelMaxScrollExtent + panelHeightClosed + 2;
                },
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
          Offstage(
            offstage: !isSecondWidgetVisible,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightOpened2,
              minHeight: panelHeightClosed2,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => PanelWidget2(
                controller: controller,
              ),
              onPanelSlide: (position) => setState(
                () {
                  final panelMaxScrollExtent =
                      panelHeightOpened - panelHeightClosed;
                  fabHeight =
                      position * panelMaxScrollExtent + panelHeightClosed + 2;
                },
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
          Offstage(
            offstage: !isThirdWidgetVisible,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightOpened2,
              minHeight: panelHeightClosed2,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => FieldPanel(
                controller: controller,
              ),
              onPanelSlide: (position) => setState(
                () {
                  final panelMaxScrollExtent =
                      panelHeightOpened - panelHeightClosed;
                  fabHeight =
                      position * panelMaxScrollExtent + panelHeightClosed + 2;
                },
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(DateTime.now());
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

  void _setPolygon(LatLng point) {
    setState(() {
      print(
          'Polygon | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
    });
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: AppColors.whiteColor,
        fillColor: AppColors.whiteColor.withOpacity(0.15),
      ),
    );
  }

  Widget _fabPolygon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.small(
          backgroundColor: AppColors.Green,
          onPressed: () {
            setState(() {
              _isMarker = true;
              _isPolygon = false;
              _polygons.clear();
            });
          },
          child: Icon(Icons.remove),
        ),
        FloatingActionButton.extended(
          onPressed: () {
            //Remove the last point setted at the polygon
            setState(() {
              polygonLatLngs.removeLast();
            });
          },
          icon: Icon(Icons.remove),
          label: Text('Буцах'),
          backgroundColor: Color.fromARGB(200, 15, 118, 109),
        ),
      ],
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  // await Geolocator.openLocationSettings();
  requestMLocationPermissions();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
