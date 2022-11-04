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
import 'package:coord_convert/coord_convert.dart';
import '../res/components/field_panel.dart';
import '../res/components/ndvi_button.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
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

const coords = Coords(
  47.92424770803818,
  106.90079705604086,
); // Coords(lat, lng)

// WGS-84 from GCJ-02
final Coords fromGCJ02 = CoordConvert.gcj02towgs84(coords);

// WGS-84 from BD-09
final Coords fromBD09 = CoordConvert.bd09towgs84(coords);

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final MapType _currentMapType = MapType.satellite;
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};
  LatLng firstLocation = const LatLng(
    47.92424770803818,
    106.90079705604086,
  );
  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) {
  //     print("error$error");
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

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
    polygonCoords.add(const LatLng(47.926575, 106.898016));
    polygonCoords.add(const LatLng(47.921978, 106.893066));
    polygonCoords.add(const LatLng(47.920036, 106.897168));
    polygonCoords.add(const LatLng(47.925019, 106.905391));
    Set<Polygon> polygonSet = {};
    polygonSet.add(Polygon(
        polygonId: const PolygonId('test'),
        points: polygonCoords,
        strokeWidth: 2,
        fillColor: click
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
                    zoom: 15,
                  ),
                  mapType: _currentMapType,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    addMarker('id', firstLocation);
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId('currentCircle'),
                      center: const LatLng(
                        47.92424770803818,
                        106.90079705604086,
                      ),
                      radius: 100,
                      fillColor: const Color.fromARGB(255, 180, 255, 165)
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
                    // setState(() {
                    //   click = !click;
                    // });
                    _determinePosition().then(
                      (value) async {
                        print("my current location"); //wsg84
                        print("${value.latitude} ${value.longitude}");
                        addMarker('2', LatLng(value.latitude, value.longitude));
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
              Positioned(
                bottom: 450,
                left: 370,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  onPressed: () {
                    setState(() {
                      click = !click;
                    });
                  },
                  child: const Icon(
                    Icons.swap_calls,
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
                    addMarker('id', firstLocation);
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId('currentCircle'),
                      center: const LatLng(
                        47.92424770803818,
                        106.90079705604086,
                      ),
                      radius: 100,
                      fillColor: const Color.fromARGB(255, 25, 96, 10)
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
                    // setState(() {
                    //   click = !click;
                    // });
                    _determinePosition().then(
                      (value) async {
                        print("my current location"); //wsg84
                        print("${value.latitude} ${value.longitude}");
                        addMarker('2', LatLng(value.latitude, value.longitude));
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
              Positioned(
                bottom: 450,
                left: 370,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  onPressed: () {
                    setState(() {
                      click = !click;
                    });
                  },
                  child: const Icon(
                    Icons.swap_calls,
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
//
//
//
//
//

  Column SecondFab(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: clicked == index ? 3 : 0,
                          color: AppColors.Green),
                      color: const Color.fromARGB(255, 239, 239, 239)
                          .withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
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

////
//////
  ///
  ///
  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'title of place',
        snippet: 'hahhahahhaha',
      ),
    );
    _markers[id] = marker;
    setState(() {});
  }
}
