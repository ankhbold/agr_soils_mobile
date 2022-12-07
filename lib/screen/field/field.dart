import 'dart:async';
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
import 'package:mvvm/screen/field/third_panel_widget.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:mvvm/widget/custom_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'ndvi_button.dart';
import '../../widget/note_add_button.dart';

bool _isPolygon = false; //Default
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

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _markerIdCounter = 1;
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
  Future<Null> _refresh() async {
    click;
    // You can do part here what you want to refresh
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;

    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;

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
                                isFirstWidgetVisible = false;
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
                                    target: LatLng(
                                        value.latitude, value.longitude));
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
        body: RefreshIndicator(
            onRefresh: _refresh,
            child: FirstWidget(panelHeightOpened, panelHeightClosed, context)));
  }

  Stack FirstWidget(double panelHeightOpened, double panelHeightClosed,
      BuildContext context) {
    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.65;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
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
                                title: 'Roça',
                                snippet: 'Um bom lugar para estar'),
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
              ],
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
                                title: 'Roça',
                                snippet: 'Um bom lugar para estar'),
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
              ],
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
                                title: 'Roça',
                                snippet: 'Um bom lugar para estar'),
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
              ],
            ),
          ),
        ),
        Visibility(
          visible: isFirstWidgetVisible ? true : false,
          child: Positioned(
            bottom: fabHeight,
            child: Column(
              children: [
                click ? FloatingFab() : SecondFab(context),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column SecondFab(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.22,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 239, 239)
                          .withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: click ? 2 : 0, color: AppColors.Green)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        clicks = !clicks;
                        clicked = index;
                      });
                    },
                    child: Ink(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tabs[index],
                            Text(
                              'Nov 23',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        NdviButton(),
      ],
    );
  }

  Stack ThirdWidget(double panelHeightOpened, double panelHeightClosed,
      BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          backdropEnabled: true,
          maxHeight: panelHeightOpened,
          minHeight: panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          panelBuilder: (controller) => ThirdPanelWidget(
            controller: controller,
          ),
          onPanelSlide: (position) => setState(
            () {
              final panelMaxScrollExtent =
                  panelHeightOpened - panelHeightClosed;
              fabHeight =
                  position * panelMaxScrollExtent + panelHeightClosed + 10;
            },
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: firstLocation,
                    zoom: 14.5,
                  ),
                  mapType: _currentMapType,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  // polygons: myPolygon(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ThirdPanel extends StatefulWidget {
  ThirdPanel({super.key});

  @override
  State<ThirdPanel> createState() => _ThirdPanelState();
}

class _ThirdPanelState extends State<ThirdPanel> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return ListView(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
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
                height: screenHeight * 0.02,
              ),
              addHeader(screenwidth: screenwidth),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // SizedBox(
              //   height: screenHeight * 0.03,
              // ),
              NotesTextField(
                screenHeight: screenHeight,
                screenwidth: screenwidth,
              ),
              InkWell(
                  child: Ink(
                width: screenwidth * 0.9,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.Green,
                    ),
                    SizedBox(
                      width: screenwidth * 0.02,
                    ),
                    Text(
                      'Зураг оруулах',
                      style: TextStyle(
                          color: AppColors.Green, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Line3(),
              Container(
                height: screenHeight * 0.5,
                color: const Color.fromARGB(255, 240, 240, 240),
              )
            ],
          ),
        ),
      ),
    ]);
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

class FieldSheet extends StatefulWidget {
  const FieldSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<FieldSheet> createState() => _FieldSheetState();
}

class _FieldSheetState extends State<FieldSheet> {
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
                      setState(() {
                        _isPolygon = true;
                        _isMarker = false;
                      });
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
