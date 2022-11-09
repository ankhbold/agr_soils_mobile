import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/res/components/field_sheet_button.dart';
import 'package:mvvm/res/components/floating_fields.dart';
import 'package:mvvm/res/components/floating_items.dart';
import 'package:mvvm/res/components/panel_widget.dart';
import 'package:mvvm/res/components/round_sheet_button.dart';
import 'package:mvvm/res/components/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../res/components/field_panel.dart';
import '../res/components/ndvi_button.dart';

final Set<Marker> _markers = {};

LocationSettings locationSettings = const LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
  print(position == null
      ? 'Unknown'
      : '${position.latitude.toString()}, ${position.longitude.toString()}');
});

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
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
bool click = true;
bool clicks = true;

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final MapType _currentMapType = MapType.satellite;

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
  int clicked = 0;
  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [];

    polygonCoords.add(const LatLng(50.056588, 105.810508));
    polygonCoords.add(const LatLng(50.060662, 105.821967));
    polygonCoords.add(const LatLng(50.057155, 105.827509));
    polygonCoords.add(const LatLng(50.050830, 105.819745));
    polygonCoords.add(const LatLng(50.053236, 105.808501));

    Set<Polygon> polygonSet = {};
    polygonSet.add(Polygon(
        polygonId: const PolygonId('test'),
        points: polygonCoords,
        strokeWidth: 2,
        fillColor: clicks
            ? const Color.fromARGB(255, 255, 173, 73).withOpacity(0.9)
            : const Color.fromARGB(255, 195, 107, 0).withOpacity(0.9),
        strokeColor: const Color.fromARGB(255, 0, 0, 0))); //color of the border
    return polygonSet;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    final panelHeightClosed = MediaQuery.of(context).size.height * 0.088;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.035,
                  ),
                  const Season(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const FieldsSheet(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  const RoundSheetButton(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        ],
      ),
      body: click
          ? FirstWidget(panelHeightOpened, panelHeightClosed, context)
          : SecondWidget(panelHeightOpened, panelHeightClosed, context),
    );
  }

  Stack FirstWidget(double panelHeightOpened, double panelHeightClosed,
      BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // _buildMap(),

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
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId(
                        'currentCircle',
                      ),
                      center: const LatLng(
                        50.054818,
                        105.820441,
                      ),
                      radius: 180,
                      fillColor: const Color.fromARGB(255, 224, 146, 0)
                          .withOpacity(0.9),
                      strokeColor: const Color.fromARGB(255, 0, 0, 0),
                      strokeWidth: 2,
                    ),
                  },
                  polygons: myPolygon(),
                ),
              ),
              Positioned(
                bottom: 380,
                left: 370,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  onPressed: () {
                    _determinePosition().then(
                      (value) async {
                        print("my current location"); //wsg84
                        print("${value.latitude} ${value.longitude}");
                        CameraPosition cameraPosition = CameraPosition(
                            zoom: 17,
                            target: LatLng(value.latitude, value.longitude));
                        final GoogleMapController controller = _mapController;

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
        ),

        Positioned(
          bottom: fabHeight,
          child: const FloatingFab(),
        ),
      ],
    );
  }

//
//
//
//
//
  Stack SecondWidget(double panelHeightOpened, double panelHeightClosed,
      BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // _buildMap(),

        SlidingUpPanel(
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
                    zoom: 15,
                  ),
                  mapType: _currentMapType,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId('currentCircle'),
                      center: const LatLng(
                        47.92424770803818,
                        106.90079705604086,
                      ),
                      radius: 100,
                      fillColor: clicks
                          ? const Color.fromARGB(255, 25, 96, 10)
                              .withOpacity(0.9)
                          : Colors.blue,
                      strokeColor: const Color.fromARGB(255, 0, 0, 0),
                      strokeWidth: 2,
                    ),
                  },
                  polygons: myPolygon(),
                ),
              ),
              Positioned(
                bottom: 380,
                left: 370,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  onPressed: () {
                    // setState(() {
                    //   click = !click;
                    // });
                    _determinePosition().then(
                      (value) async {
                        print("my current location"); //wsg84
                        print("${value.latitude} ${value.longitude}");
                        CameraPosition cameraPosition = CameraPosition(
                            zoom: 17,
                            target: LatLng(value.latitude, value.longitude));
                        final GoogleMapController controller = _mapController;

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
        ),

        Positioned(
          bottom: fabHeight,
          child: SecondFab(context),
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
}
