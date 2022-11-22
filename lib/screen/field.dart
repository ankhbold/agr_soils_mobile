import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/location/location.dart';
import 'package:mvvm/res/components/floating_fields.dart';
import 'package:mvvm/res/components/floating_items.dart';
import 'package:mvvm/res/components/panel_widget.dart';
import 'package:mvvm/res/components/third_panel_widget.dart';
import 'package:mvvm/screen/profile_screen.dart';
import 'package:mvvm/widget/custom_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../res/components/field_panel.dart';
import '../res/components/ndvi_button.dart';
import '../widget/note_add_button.dart';

bool note = true;

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

List<String> items = [
  "NDVI",
  "NDVI - ялгавартай",
  "Хур Тунадас",
  "Таримал",
  "Ургац/дундаж",
  "Үрэлсэн огноо",
  "Хураах огноо",
  "NDVI дундаж",
];
//------
bool click = true;
//------
bool clicks = true;

//-------
class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final MapType _currentMapType = MapType.satellite;

  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

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
  int clicked = 0;
  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [];

    polygonCoords.add(const LatLng(50.056588, 105.810508));
    polygonCoords.add(const LatLng(50.060662, 105.821967));
    polygonCoords.add(const LatLng(50.057155, 105.827509));
    polygonCoords.add(const LatLng(50.050830, 105.819745));
    polygonCoords.add(const LatLng(50.053236, 105.808501));

    Set<Polygon> polygonSet = {};
    polygonSet.add(
      Polygon(
        polygonId: const PolygonId('test'),
        points: polygonCoords,
        strokeWidth: 2,
        fillColor: clicks
            ? const Color.fromARGB(255, 255, 173, 73).withOpacity(0.9)
            : const Color.fromARGB(255, 195, 107, 0).withOpacity(0.9),
        strokeColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    ); //color of the border
    return polygonSet;
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = note
        ? MediaQuery.of(context).size.height * 0.1
        : MediaQuery.of(context).size.height * 0.29;
    final panelHeightOpened = note
        ? MediaQuery.of(context).size.height * 0.65
        : MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: FloatingActionButton.small(
              backgroundColor:
                  const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
              elevation: 0,
              onPressed: () {
                _determinePosition().then(
                  (value) async {
                    print("my current location"); //wsg84
                    print("${value.latitude} ${value.longitude}");
                    CameraPosition cameraPosition = CameraPosition(
                        zoom: 17,
                        target: LatLng(value.latitude, value.longitude));
                    final GoogleMapController controller = _mapController;
                    addMarker(
                        'current', LatLng(value.latitude, value.longitude));

                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(cameraPosition));
                    setState(() {});
                  },
                );
              },
              child: const Icon(
                Icons.location_on,
                color: AppColors.Green,
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      appBar: customAppBar(context),
      body: note
          ? FirstWidget(panelHeightOpened, panelHeightClosed, context)
          : ThirdWidget(panelHeightOpened, panelHeightClosed, context),
    );
  }

  Stack FirstWidget(double panelHeightOpened, double panelHeightClosed,
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
          panelBuilder: (controller) => PanelWidget(
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
                    addMarker('test', firstLocation);
                  },
                  // polygons: myPolygon(),
                  markers: _markers.values.toSet(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: fabHeight,
          child: note ? FloatingFab() : SizedBox(),
        ),
      ],
    );
  }

//
  addMarker(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: 'Таны байгаа газар'));
    _markers[id] = marker;
    setState(() {});
  }

//

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
                    border: Border.all(
                        width: clicked == index ? 3 : 0,
                        color: AppColors.Green),
                    color: const Color.fromARGB(255, 239, 239, 239)
                        .withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        clicks = !clicks;
                        clicked = index;
                      });
                    },
                    child: Ink(
                      child: Center(
                        child: Tabs[index],
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
                    addMarker('test', firstLocation);
                  },
                  // polygons: myPolygon(),
                  markers: _markers.values.toSet(),
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
