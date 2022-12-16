import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/location/location.dart';
import 'package:mvvm/screen/field%20screen/field_panel.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/floating_fields.dart';
import 'package:mvvm/screen/field%20screen/floating_items.dart';
import 'package:mvvm/screen/field%20screen/panel_widget.dart';
import 'package:mvvm/widget/custom_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

bool _isPolygon = false; //Default
bool fclick = true;
bool _isMarker = true;
bool note = true;
//------
bool click = true;
//------
bool clicks = true;
//-------
int clicked = 0;
bool isFirstWidgetVisible = true;
bool isSecondWidgetVisible = false;
bool isThirdWidgetVisible = false;
bool isAddFieldWidgetVisible = false;
bool isFabVisible = true;
bool _showText = true;
Set<Polygon> _polygons = HashSet<Polygon>();

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  Set<Marker> _markers = HashSet<Marker>();

  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _markerIdCounter = 1;
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(
      () {
        print(DateTime.now());
        print(
            'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
        _markers.add(
          Marker(
            markerId: MarkerId(markerIdVal),
            position: point,
          ),
        );
      },
    );
  }

  void _setPolygon(LatLng point) {
    setState(() {
      print(
        'Polygon | Latitude: ${point.latitude}  Longitude: ${point.longitude}',
      );
    });
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: AppColors.whiteColor,
        fillColor: Color.fromARGB(255, 255, 177, 32).withOpacity(0.15),
      ),
    );
  }

  void toggleTextVisibility() {
    setState(() {
      _showText = !_showText;
    });
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

  final MapType _currentMapType = MapType.hybrid;

  late GoogleMapController _mapController;

  LatLng firstLocation = const LatLng(50.054818, 105.820441);

  static double fabHeightClosed = 95.0;
  double fabHeight = fabHeightClosed;
  final List<Tab> myTabs = <Tab>[
    const Tab(
      child: FloatingFab(),
    ),
    const Tab(
      child: FloatingFields(),
    ),
  ];
  // Future<Null> _refresh() async {
  //   click;
  // }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;
    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.2;
    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed3 = MediaQuery.of(context).size.height * 0.07;

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
                              isFabVisible = false;
                              // note = !note;
                              isFirstWidgetVisible = false;
                              isAddFieldWidgetVisible = false;
                              isSecondWidgetVisible = true;
                              isThirdWidgetVisible = false;
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
          GoogleMap(
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
                            title: 'Roça', snippet: 'Um bom lugar para estar'),
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
              maxHeight: panelHeightOpened,
              minHeight: panelHeightClosed,
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
          Offstage(
            offstage: !isAddFieldWidgetVisible,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightClosed3,
              minHeight: panelHeightClosed3,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => AddField(),
              onPanelSlide: (position) => setState(
                () {
                  final panelMaxScrollExtent =
                      panelHeightOpened - panelHeightClosed;
                  fabHeight =
                      position * panelMaxScrollExtent + panelHeightClosed + 2;
                },
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
          Visibility(
            visible: isFabVisible ? true : false,
            child: Positioned(
              bottom: fabHeight,
              child: Column(
                children: [
                  fclick ? FloatingFab() : SecondFab(),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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

class FieldSheet extends StatelessWidget {
  const FieldSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(right: 50, left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Үйлдлүүд',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 500,
                  child: InkWell(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.touch_app,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Газрын зураг дээр сонголт хийх'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: 40,
                  width: 500,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      isFabVisible = false;
                      _isPolygon = true;
                      _isMarker = false;
                      isAddFieldWidgetVisible = true;
                      isFirstWidgetVisible = false;

                      isSecondWidgetVisible = false;
                      isThirdWidgetVisible = false;
                    },
                    child: Ink(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.draw_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Хүрээ Зурах'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddField extends StatelessWidget {
  const AddField({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        decoration: BoxDecoration(),
        height: MediaQuery.of(context).size.height * 0.06,
        child: TextButton(
          onPressed: () {
            _isMarker = true;
            _isPolygon = false;
            _polygons.clear();
            isAddFieldWidgetVisible = false;
            isFabVisible = true;
            isFirstWidgetVisible = true;
            isSecondWidgetVisible = false;
            isThirdWidgetVisible = false;
          },
          child: Text(
            'Буцах',
            style: TextStyle(
                color: Color.fromARGB(255, 163, 45, 37), fontSize: 18),
          ),
        ),
      ),
    );
  }
}
