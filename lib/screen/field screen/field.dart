import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../conf_global.dart';
import '../../constants/color.dart';
import '../field%20screen/field_sheet_button.dart';
import '../field%20screen/floatingss/floating_items.dart';
import '../field%20screen/geojson/get_geo_api.dart';
import '../field%20screen/panel_widget.dart';
import '../season/season_choice_page.dart';
import 'field_panel.dart';

bool mapsol = true;

List<Marker> markers = [];
bool isChoose = true;
bool isPolygon = false; //Default
bool fclick = true;
bool isMarker = false;
bool note = true;
bool click = true;
bool clicks = true;
int clicked = 0;
bool isFirstWidgetVisible = true;
bool isSecondWidgetVisible = false;
bool isThirdWidgetVisible = false;
bool isAddFieldWidgetVisible = false;
bool isFabVisible = true;
late MapController _mapController;
double _zoom = 10.0;

var heightS = 10.5;
Future<void> TapMove(LatLng latLng) async {
  await Future.delayed(Duration(seconds: 1));

  _mapController.move(LatLng(49.939048, 105.841644), _zoom + 2.5);
}

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  LatLng firstLocation = LatLng(49.939048, 105.841644);
  List<LatLng> polygonPoints = [];
  List<Polygon> polygons = [];
  List<LatLng> currentPolygon = [];
  var sate =
      'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbb2d9176fe69751440499?appid=515ebec1b32cec8d92b4de210361642b';
  var png =
      'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';

  var falseColor = '';
  static double fabHeightClosed = 90.0;
  double fabHeight = fabHeightClosed;
  var wmsLayer = Globals.isLogin
      ? WMSTileLayerOptions(
          baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?',
          layers: ['agrgis:agr_parcel'],
          transparent: true,
          format: 'image/png',
          version: '1.1.1',
          otherParameters: {
            'CQL_FILTER': 'person_id = ${Globals.personId}',
            // 'person_id': '8sdvcsd2',
          },
        )
      : WMSTileLayerOptions(baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms');
  var tileLayer = TileLayer(
    urlTemplate: 'https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
  );

  void changeStage() {
    setState(() {
      isFabVisible = false;
      isFirstWidgetVisible = false;
      isAddFieldWidgetVisible = false;
      isSecondWidgetVisible = true;
      isThirdWidgetVisible = false;
    });
  }

  void changePolygonStage() {
    setState(() {
      isFabVisible = false;
      isPolygon = true;
      isMarker = false;
      isAddFieldWidgetVisible = true;
      isFirstWidgetVisible = false;
      isSecondWidgetVisible = false;
      isThirdWidgetVisible = false;
    });
  }

  GeoRepository repository = GeoRepository();
  @override
  void initState() {
    _mapController = MapController();

    super.initState();
  }

  void _navigateToPosition() {
    determinePosition().then(
      (value) {
        _mapController.move(LatLng(value.latitude, value.longitude), 17.0);
      },
    );
  }

  void _addMarkers(point) {
    markers.clear();
    markers.add(
      Marker(
        point: point,
        builder: (context) => Container(
          child: const Icon(
            Icons.location_on,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 30.0,
          ),
        ),
      ),
    );
    print(point);
  }

  void zoomToFeature(LatLng center) {
    _mapController.move(center, 15.0);
  }

  void _addPolygons(point) {
    polygonPoints.add(point);
    polygons.add(
      Polygon(
        points: polygonPoints,
        borderStrokeWidth: 2,
        borderColor: Color.fromARGB(255, 255, 255, 255),
        color: Color.fromARGB(81, 255, 255, 255),
      ),
    );
    setState(() {});
  }

  Future<void> _handleTap(LatLng latLng) async {
    await Future.delayed(Duration(milliseconds: 300));

    _mapController.move(latLng, _zoom + 2.5);
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.24;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.9;
    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.3;
    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.85;
    final panelHeightClosed3 = MediaQuery.of(context).size.height * 0.07;
    final panelHeightClosed4 = MediaQuery.of(context).size.height * 0.265;
    final panelHeightClosed5 = MediaQuery.of(context).size.height * 0.44;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: isPolygon
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              polygonPoints.removeLast();
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                                size: 20,
                                color: AppColors.Green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.small(
                          backgroundColor: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              _navigateToPosition();
                            });
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
        body: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onTap: (tapPosition, LatLng latlng) async {
                  setState(() {
                    if (isPolygon) {
                      setState(() {
                        _addPolygons(latlng);
                        markers.clear();
                      });
                    } else if (isMarker) {
                      setState(() {
                        _addMarkers(latlng);
                        polygonPoints.clear();
                      });
                    } else if (isChoose) {
                      print('orsin');
                      setState(() {
                        Globals.changeLatitude(latlng.latitude);
                        markers.clear();
                        print(latlng);
                        _handleTap(latlng);
                      });
                    }
                  });
                },
                center: firstLocation,
                zoom: _zoom,
              ),
              children: [
                // layerOption,
                tileLayer,

                TileLayer(backgroundColor: Colors.transparent, wmsOptions: wmsLayer),

                TileLayer(
                  backgroundColor: Colors.transparent,
                  urlTemplate: png,
                ),
                MarkerLayer(
                  markers: markers,
                ),

                PolygonLayer(
                  polygons: polygons,
                  // polygonCulling: true,
                ),
              ],
            ),
            fieldBar(),
            Offstage(
                offstage: mapsol,
                child: Container(
                  height: 600,
                  child: PanelWidget(
                    controller: ScrollController(),
                  ),
                )),
            Offstage(
              offstage: !isFirstWidgetVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingFab(),
                ],
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
                    final panelMaxScrollExtent = panelHeightOpened - panelHeightClosed;
                    fabHeight = position * panelMaxScrollExtent + panelHeightClosed + 2;
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
                color: Colors.transparent,
                maxHeight: panelHeightOpened,
                minHeight: panelHeightClosed4,
                parallaxEnabled: true,
                parallaxOffset: .5,
                panelBuilder: (controller) => FieldPanel(
                  controller: controller,
                ),
                onPanelSlide: (position) => setState(
                  () {
                    final panelMaxScrollExtent = panelHeightOpened - panelHeightClosed;
                    fabHeight = position * panelMaxScrollExtent + panelHeightClosed + 2;
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
                panelBuilder: (controller) => AddField(
                  clear: () {
                    isChoose = true;
                    isMarker = false;
                    isPolygon = false;
                    polygonPoints.clear();
                    isAddFieldWidgetVisible = false;
                    isFabVisible = true;
                    isFirstWidgetVisible = true;
                    isSecondWidgetVisible = false;
                    isThirdWidgetVisible = false;
                  },
                ),
                onPanelSlide: (position) => setState(
                  () {
                    final panelMaxScrollExtent = panelHeightOpened - panelHeightClosed;
                    fabHeight = position * panelMaxScrollExtent + panelHeightClosed + 2;
                  },
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
          ],
        ));
  }

  PreferredSize fieldBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(500.0),
      child: Container(
        decoration: BoxDecoration(
          // color: AppColors.Green,
          gradient: AppColors.grad,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 0.4,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.13,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                decoration: BoxDecoration(
                  color: Color.fromARGB(36, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SeasonChoicePage(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 12.0,
              ),
              child: FieldsSheet(
                notecreate: changeStage,
                polygoncreate: changePolygonStage,
              ),
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => PanelWidget(controller: ScrollController())));
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.only(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 20,
                              color: AppColors.Green,
                            ),
                            Text(
                              'Талбай хайх',
                              style: TextStyle(color: AppColors.Green, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  // await Geolocator.openLocationSettings();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class AddField extends StatelessWidget {
  AddField({super.key, this.clear});
  Function? clear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        decoration: BoxDecoration(),
        height: MediaQuery.of(context).size.height * 0.06,
        child: TextButton(
          onPressed: () {
            clear!();
          },
          child: Text(
            'Буцах',
            style: TextStyle(color: Color.fromARGB(255, 183, 45, 37), fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class TextFieldField extends StatefulWidget {
  const TextFieldField({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldField> createState() => _TextFieldFieldState();
}

class _TextFieldFieldState extends State<TextFieldField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 20,
                        color: AppColors.Green,
                      ),
                      Text('Талбай хайх'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
