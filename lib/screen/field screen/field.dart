import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/field_panel.dart';
import 'package:mvvm/screen/field%20screen/field_sheet_button.dart';
import 'package:mvvm/screen/field%20screen/floating_fields.dart';
import 'package:mvvm/screen/field%20screen/floating_items.dart';
import 'package:mvvm/screen/field%20screen/panel_widget.dart';
import 'package:mvvm/screen/field%20screen/season/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

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
  int selectedIndex = 1;
  late MapShapeSource dataSource;
  // late MapZoomPanBehavior _mapZoomPanBehavior;
  late _CustomZoomPanBehavior _mapZoomPanBehavior;
  late MapTileLayerController _controller;
  late List<Model> data;
//
  @override
  void initState() {
    data = <Model>[
      Model('Дунд ширээ 135 га',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Хоёр даваа ', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 8 /16/ ha',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 14', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Генерал толгой 1',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Хоёр даваа 1', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Эрээн 6', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Баруун ширээ', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model(
          'Усалгаатай 10', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 1', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Шарилжит 2', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model(
          'Рашаант 243га', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Шарилжит 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 2', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 5', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 7 /312/',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Рашаант 3', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Эрээн 10', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Эрээн 3', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Эрээн 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Эрээн 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Хутаг-Өндөр /2nd 10/',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      Model('Мойлын ар 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
    ];
    _controller = MapTileLayerController();

    _mapZoomPanBehavior = _CustomZoomPanBehavior()
      ..focalLatLng = MapLatLng(49.987250, 105.785922)
      // ..maxZoomLevel
      // ..minZoomLevel
      ..enableDoubleTapZooming = true
      ..zoomLevel = 11
      ..onTap = updateMarkerChange;

    dataSource = MapShapeSource.network(
      'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247',
      shapeDataField: 'name',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].name,
      shapeColorValueMapper: (int index) => data[index].color,
      // shapeColorMappers: shape
    );

    super.initState();
  }

  void _navigateToPosition() {
    // _determinePosition().then(
    //   (value) =>
    //       _controller.move(LatLng(value.latitude, value.longitude), 13.0),
    // );
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
  }
  // void _addMarkers(point) {
  //   markers.add(Marker(
  //     point: point,
  //     builder: (context) => Container(
  //       child: const Icon(
  //         Icons.location_on,
  //         color: Color.fromARGB(255, 255, 255, 255),
  //         size: 30.0,
  //       ),
  //     ),
  //   ));
  // }

  // void _addPolygons(point) {
  //   polygonPoints.add(point);
  // }

  // var tilelayer = TileLayer(
  //     urlTemplate:
  //         "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
  //     additionalOptions: const {
  //       'attribution':
  //           'Map data &copy; <a href="https://www.esri.com/en-us/home">Esri</a>',
  //     },
  //     subdomains: [
  //       'a',
  //       'b',
  //       'c'
  //     ]);
  // var wmsLayer = WMSTileLayerOptions(
  //   baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?person_id=3580',
  //   layers: ['agrgis:agr_parcel'],
  //   transparent: true,
  //   format: 'image/png',
  //   version: '1.1.1',
  // );
  // var polygonLayer = PolygonLayer(
  //   polygons: [
  //     Polygon(
  //       points: polygonPoints,
  //       borderStrokeWidth: 4,
  //       borderColor: const Color.fromARGB(120, 244, 67, 54),
  //       isFilled: true,
  //       color: const Color.fromARGB(81, 244, 67, 54),
  //     ),
  //   ],
  // );
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
                          _mapZoomPanBehavior.focalLatLng =
                              MapLatLng(49.987250, 105.785922);
                          _mapZoomPanBehavior.zoomLevel = 11;
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
      body: Stack(
        children: [
          MapTileLayer(
            initialFocalLatLng: MapLatLng(49.987250, 105.785922),
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
                    color: Colors.red,
                    size: 30,
                  ));
            },
            urlTemplate:
                "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
            sublayers: [
              MapShapeSublayer(
                // color: Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)
                source: dataSource,
                strokeColor: Colors.white,
                strokeWidth: 1,
                selectedIndex: selectedIndex,
                selectionSettings: MapSelectionSettings(
                  strokeWidth: 1,
                  color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
                  strokeColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                onSelectionChanged: (int index) {
                  setState(() {
                    _mapZoomPanBehavior.zoomLevel = 13;
                    selectedIndex = index;
                    _mapZoomPanBehavior.focalLatLng = MapLatLng(
                      _markerPosition.latitude,
                      _markerPosition.longitude,
                    );
                  });
                },
              ),
            ],
          ),
          // FlutterMap(
          //   mapController: _mapController,
          //   options: MapOptions(
          //     onTap: (tapPosition, point) {
          //       setState(() {
          //         if (isPolygon) {
          //           setState(() {
          //             _addPolygons(point);
          //             markers.clear();
          //           });
          //         } else if (isMarker) {
          //           _addMarkers(point);
          //           polygonPoints.clear();
          //         }
          //       });
          //     },
          //     center: firstLocation,
          //     zoom: 11.5,
          //   ),
          //   children: [
          //     tilelayer,
          //     MarkerLayer(
          //       markers: markers,
          //     ),
          //    polygonLayer,
          //   ],
          // ),
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
                  // const RoundSheetButton(),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.02,
                  // ),
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
                color: Color.fromARGB(255, 163, 45, 37), fontSize: 18),
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
