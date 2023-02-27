import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/screen/field%20screen/field_panel.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/floatingss/floating_items.dart';
import 'package:mvvm/screen/field%20screen/geojson/get_geo_api.dart';
import 'package:mvvm/screen/field%20screen/panel_widget.dart';
import 'package:mvvm/screen/field%20screen/season/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../constants/color.dart';

bool mapsol = true;
List<LatLng> polygonPoints = [];

List<Marker> markers = [];
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
void isMap() {
  mapsol = true;
}

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  LatLng firstLocation = LatLng(50.028372, 105.817248);
  // var wms = 'http://103.143.40.250:8080/geoserver/agrgis/wms?person_id=3580';wmssss
  var wms =
      'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247';

  var sate =
      'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbb2d9176fe69751440499?appid=515ebec1b32cec8d92b4de210361642b';
  var png =
      // 'http://api.agromonitoring.com/image/1.0/10063c34200/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
      'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
  // 'http://api.agromonitoring.com/tile/1.0/%7Bz%7D/%7Bx%7D/%7By%7D/11063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
  static double fabHeightClosed = 90.0;
  double fabHeight = fabHeightClosed;
  var wmsLayer = WMSTileLayerOptions(
    baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?person_id=3580',
    // baseUrl:
    //     'http://103.143.40.250:8080/geoserver/agrgis/wms?person_id?company_person_id=626247',

    layers: ['agrgis:agr_parcel'],
    transparent: true,
    format: 'image/png',
    version: '1.1.1',
    // styles:
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

  void isField() {
    setState(() {
      mapsol = true;
    });
  }

  GeoRepository repository = GeoRepository();
  @override
  void initState() {
    // fetch();

    _mapController = MapController();
    super.initState();
  }

  void _navigateToPosition() {
    determinePosition().then(
      (value) {
        _mapController.move(LatLng(value.latitude, value.longitude), 13.0);
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

  void _addPolygons(point) {
    polygonPoints.add(point);
  }

  // late MapShapeSource dataSource;

  late LatLng _tapLocation;

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.24;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.2;
    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed3 = MediaQuery.of(context).size.height * 0.07;
    final panelHeightClosed4 = MediaQuery.of(context).size.height * 0.265;
    final panelHeightClosed5 = MediaQuery.of(context).size.height * 0.44;

    return Scaffold(
        appBar: fieldBar(),
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
                              )),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.small(
                          backgroundColor:
                              const Color.fromARGB(255, 239, 239, 239)
                                  .withOpacity(0.85),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              _navigateToPosition();
                              // isMap();
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
                onTap: (tapPosition, point) {
                  setState(() {
                    if (isPolygon) {
                      setState(() {
                        _addPolygons(point);
                        markers.clear();
                      });
                    } else if (isMarker) {
                      _addMarkers(point);
                      polygonPoints.clear();
                    } else {
                      print(point);
                    }
                  });
                },
                center: firstLocation,
                zoom: 11.5,
              ),
              children: [
                // layerOption,
                TileLayer(
                  urlTemplate:
                      "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                  additionalOptions: const {
                    'attribution':
                        'Map data &copy; <a href="https://www.esri.com/en-us/home">Esri</a>',
                  },
                ),
                TileLayer(
                  backgroundColor: Colors.transparent,
                  urlTemplate: png,
                ),

                TileLayer(
                  backgroundColor: Colors.transparent,
                  wmsOptions: wmsLayer,
                ),

                MarkerLayer(
                  markers: markers,
                ),

                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: polygonPoints,
                      borderStrokeWidth: 2,
                      borderColor: Color.fromARGB(255, 255, 255, 255),
                      isFilled: true,
                      color: Color.fromARGB(81, 255, 255, 255),
                    ),
                  ],
                ),
              ],
            ),

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

              // child: SlidingUpPanel(
              //   backdropEnabled: true,
              //   maxHeight: panelHeightOpened,
              //   minHeight: sungah ? panelHeightClosed : panelHeightClosed5,
              //   parallaxEnabled: true,
              //   parallaxOffset: .1,
              //   color: Colors.transparent,
              //   panelBuilder: (controller) => Panelss(
              //     controller: controller,
              //   ),
              //   onPanelSlide: (position) => setState(
              //     () {
              //       final panelMaxScrollExtent =
              //           panelHeightOpened - panelHeightClosed;
              //       fabHeight =
              //           position * panelMaxScrollExtent + panelHeightClosed;
              //     },
              //   ),
              //   borderRadius: const BorderRadius.vertical(
              //     top: Radius.circular(30),
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingFab(),
                  // Container(
                  //   height: 10,
                  //   decoration: BoxDecoration(
                  //     gradient: AppColors.grad,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(30),
                  //       topRight: Radius.circular(30),
                  //     ),
                  //   ),
                  // )
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
            // Visibility(
            //   visible: isFabVisible ? true : false,
            //   child: Positioned(
            //     bottom: fabHeight,
            //     child: Column(
            //       children: [
            //         fclick ? FloatingFab() : SecondFab(),
            //         SizedBox(
            //           height: 5,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
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
        height: 115,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // SizedBox(
            //   width: 5,
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 10),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(36, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Season()),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 12.0, left: 10, right: 10),
              child: FieldsSheet(
                notecreate: changeStage,
                polygoncreate: changePolygonStage,
              ),
            ),
            SizedBox(
              width: 40,
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
                        mapsol = !mapsol;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(36, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.only(),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.search,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              'Талбай хайх',
                              style: TextStyle(color: Colors.white),
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
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
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
            isMarker = true;
            isPolygon = false;
            polygonPoints.clear();
            isAddFieldWidgetVisible = false;
            isFabVisible = true;
            isFirstWidgetVisible = true;
            isSecondWidgetVisible = false;
            isThirdWidgetVisible = false;
          },
          child: Text(
            'Буцах',
            style: TextStyle(
                color: Color.fromARGB(255, 183, 45, 37), fontSize: 18),
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
                setState(() {
                  mapsol = true;
                });
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
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
                  // child: TextField(
                  //   decoration: InputDecoration(
                  // prefixIcon: Icon(
                  //   Icons.search,
                  //   size: 20,
                  //   color: AppColors.Green,
                  // ),
                  //     border: InputBorder.none,
                  //     hintText: 'Талбай хайна уу',
                  //   ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
