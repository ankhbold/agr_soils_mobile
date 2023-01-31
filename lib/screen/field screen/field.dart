import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/screen/field%20screen/field_panel.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/floating_fields.dart';
import 'package:mvvm/screen/field%20screen/floatingss/floating_items.dart';
import 'package:mvvm/screen/field%20screen/panel_widget.dart';
import 'package:mvvm/screen/field%20screen/season/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

import '../../constants/color.dart';
import '../../model/postModel.dart';

List<LatLng> polygonPoints = [];

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

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  LatLng firstLocation = LatLng(50.028372, 105.817248);
  var sate =
      'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbb2d9176fe69751440499?appid=515ebec1b32cec8d92b4de210361642b';
  var png =
      'http://api.agromonitoring.com/image/1.0/10063c34200/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
  static double fabHeightClosed = 90.0;
  double fabHeight = fabHeightClosed;
  final List<Tab> myTabs = <Tab>[
    const Tab(
      child: FloatingFab(),
    ),
    const Tab(
      child: FloatingFields(),
    ),
  ];

  void changeStage() {
    setState(() {
      isFabVisible = false;
      isFirstWidgetVisible = false;
      isAddFieldWidgetVisible = false;
      isSecondWidgetVisible = true;
      isThirdWidgetVisible = false;
    });
  }

  // var dataJson = Globals.jsonDataByCompanyId;
//sfmaps
  late MapLatLng _markerPosition;
  var selectedIndex = -1;
  late MapShapeSource dataSource;
  // late MapZoomPanBehavior _mapZoomPanBehavior;
  late _CustomZoomPanBehavior _mapZoomPanBehavior;
  late MapZoomPanBehavior _mapBehavior;
  late MapTileLayerController _controller;
  late List<PostModel> data = []; //

  @override
  void initState() {
    fetch();
    _controller = MapTileLayerController();

    _mapZoomPanBehavior = _CustomZoomPanBehavior()
      ..maxZoomLevel = 18
      ..minZoomLevel = 3
      ..focalLatLng = MapLatLng(49.987250, 105.785922)
      // ..onTap =
      // ..maxZoomLevel
      // ..minZoomLevel
      ..enableDoubleTapZooming = true
      ..zoomLevel = 11
      ..onTap = updateMarkerChange;

    super.initState();
  }

  void where() {
    print('${_markerPosition.latitude},${_markerPosition.longitude}');
  }

  Future fetch() async {
    data = [];
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlpSMnNmMm81VjhZMUpJRnE2YU1vR3c9PSIsInZhbHVlIjoiNEpwZERyT00zOW1OaGhBOTFvY2R2T0Y4UjdLUTBDanp5emdCWVUrOWlPZm1WUHZRU1QrWHNYTmh2NUZWTjRYTHRtbmxPZlh4SE9Ya3VJQWpJNXhkbVNQMFkyRDNJaHBEbVlXdHhJWHNMRldLOUF0TWxxNG8vZ1djUDBXc3NNdTEiLCJtYWMiOiIwOWRiZjk3YjMyYWJkZDUzOWNhNTgzMjM4ZTFlNjRiZGY2Y2E3MWIyMzRlMzVlOWIzNDUyYzM4ZmJkNTNmMTVkIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjhwdENBOWd6d2ZKZEdhU0paL0doYnc9PSIsInZhbHVlIjoiOWJ1VmQ0TlVIOUI3TmVkVzNWaFZ4ZEJXM2FtVWpKV3A5YXBvNWNZMjBSYmhJeFBBMmJ3ODRtbFJ1ZTNrdEVjc0NRc05jQzhlSnNrdnBzNW9EMTVLTllIdVRUQU5EcmcxNkpDM1NBdy9PaW5kSXFYNUphYS9URnBzcVN1OUZiaXciLCJtYWMiOiIwY2I2OTQ2ZWZlNjRmZTU2NDdhMDM5MzVmMjFkZDJmMzg0OTFlOGY5NDA4NjgzMDEzNTVhYmQyYzRiZWUzZjcwIiwidGFnIjoiIn0%3D'
    };

    final response = await http.get(
        Uri.parse(
            'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247'),
        headers: headers);

    if (response.statusCode == 200) {
      final datadd = json.decode(response.body);
      print(datadd);
      data = (datadd['features'] as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    } else {
      print(response.reasonPhrase);
    }
    if (data.isNotEmpty) {
      dataSource = MapShapeSource.network(
        'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247',
        shapeDataField: 'name',
        dataCount: data.length,
        primaryValueMapper: (int index) => data[index].properties.name,
        shapeColorValueMapper: (int index) =>
            Color.fromARGB(255, 253, 213, 34).withOpacity(0.9),
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _navigateToPosition() {
    _determinePosition().then((value) => _mapZoomPanBehavior.focalLatLng =
        MapLatLng(value.latitude, value.longitude));
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

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);

    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
    print('${_markerPosition.latitude},${_markerPosition.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;
    final panelHeightClosed2 = MediaQuery.of(context).size.height * 0.2;
    final panelHeightOpened2 = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed3 = MediaQuery.of(context).size.height * 0.07;

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: isPolygon
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            polygonPoints.removeLast();
                          });
                        },
                        child: const Text('remove pol'),
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
                          _navigateToPosition();
                          // _mapZoomPanBehavior.focalLatLng =
                          //     MapLatLng(49.969077, 105.799682);
                          _mapZoomPanBehavior.zoomLevel = 18;
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
          SfMaps(
            layers: [
              MapTileLayer(
                initialFocalLatLng: MapLatLng(49.946688, 105.806398),
                initialZoomLevel: 12,
                zoomPanBehavior: _mapZoomPanBehavior,
                onWillZoom: (MapZoomDetails detail) {
                  return true;
                },
                controller: _controller,
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: _markerPosition.latitude,
                    longitude: _markerPosition.longitude,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.transparent,
                      size: 30,
                    ),
                  );
                },
                urlTemplate:
                    "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                sublayers: [
                  // MapShapeSublayer(
                  //   // showDataLabels: true,
                  //   dataLabelSettings: MapDataLabelSettings(
                  //     textStyle: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     overflowMode: MapLabelOverflow.visible,
                  //   ),
                  //   source: MapShapeSource.network(png),
                  //   strokeColor: Colors.white.withOpacity(0.5),
                  //   strokeWidth: 2,
                  //   selectedIndex: selectedIndex,
                  //   selectionSettings: MapSelectionSettings(
                  //     strokeWidth: 2,
                  //     color:
                  //         Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                  //     strokeColor: Color.fromARGB(255, 255, 255, 255),
                  //   ),
                  //   onSelectionChanged: (int index) {
                  //     setState(() {
                  //       _mapZoomPanBehavior.zoomLevel = 13;
                  //       selectedIndex = index;
                  //       _mapZoomPanBehavior.focalLatLng = MapLatLng(
                  //         _markerPosition.latitude,
                  //         _markerPosition.longitude,
                  //       );
                  //     });
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  const Season(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  FieldsSheet(
                    notecreate: changeStage,
                    polygoncreate: changePolygonStage,
                  ),
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
                      position * panelMaxScrollExtent + panelHeightClosed;
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

class DataModel {
  DataModel(this.key, this.color, this.id);

  final String key;
  final Color color;
  final double id;
  // final double size;
}

class _CustomZoomPanBehavior extends MapZoomPanBehavior {
  _CustomZoomPanBehavior();
  late MapTapCallback onTap;

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      onTap(event.localPosition);
    }
    super.handleEvent(event);
  }
}

typedef MapTapCallback = void Function(Offset position);

class Model {
  const Model(this.name, this.color);

  final String name;

  final Color color;
}
