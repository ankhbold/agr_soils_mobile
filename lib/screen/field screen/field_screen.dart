import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/panel_widget.dart';
import 'package:mvvm/screen/field%20screen/round_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/season/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

bool _isPolygon = true;
bool _isMarker = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var firstLocation = LatLng(50.054818, 105.820441);
  double fabHeight = fabHeightClosed;
  static double fabHeightClosed = 95.0;

  late MapController _mapController;
  final int _polygonIdCounter = 1;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  void _navigateToPosition() {
    _determinePosition().then(
      (value) =>
          _mapController.move(LatLng(value.latitude, value.longitude), 13.0),
    );
  }

  void _addMarkers(point) {
    markers.add(Marker(
      point: point,
      builder: (context) => Container(
        child: const Icon(
          Icons.location_on,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 30.0,
        ),
      ),
    ));
  }

  void _addPolygons(point) {
    polygonPoints.add(point);
  }

  List<LatLng> polygonPoints = [];

  List<Marker> markers = [];
  var layerOption = TileLayer(
      urlTemplate:
          "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
      additionalOptions: const {
        'attribution':
            'Map data &copy; <a href="https://www.esri.com/en-us/home">Esri</a>',
      });
  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;
    return Scaffold(
      // appBar: customAppBar(context),

      body: Stack(children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onTap: (tapPosition, point) {
              setState(() {
                if (_isPolygon) {
                  setState(() {
                    _addPolygons(point);
                    markers.clear();
                  });
                } else if (_isMarker) {
                  _addMarkers(point);
                  polygonPoints.clear();
                }
              });
            },
            center: firstLocation,
            zoom: 12.0,
          ),
          children: [
            layerOption,
            MarkerLayer(
              markers: markers,
            ),
            PolygonLayer(
              polygons: [
                Polygon(
                  points: polygonPoints,
                  borderStrokeWidth: 4,
                  borderColor: const Color.fromARGB(120, 244, 67, 54),
                  isFilled: true,
                  color: const Color.fromARGB(81, 244, 67, 54),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
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
                  position * panelMaxScrollExtent + panelHeightClosed + 2;
            },
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
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
      ]),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.white,
        onPressed: () {
          _navigateToPosition;
        },
        child: const Icon(
          Icons.location_on,
          color: AppColors.Green,
        ),
      ),
    );
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
}
