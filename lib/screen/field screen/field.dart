import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../conf_global.dart';
import '../../constants/color.dart';
import '../../services/note_services.dart';
import '../../services/permissions/location.dart';
import '../field%20screen/floatingss/floating_items.dart';
import '../field%20screen/panel_widget.dart';
import '../notes screen/add_note.dart';
import '../season/season_choice_page.dart';
import '../unit_area/add_area.dart';
import '../unit_area/add_unit_area_page.dart';
import 'field_panel.dart';

bool mapsol = true;

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
bool isDetailAddFieldWidgetVisible = false;
bool isFabVisible = true;
late MapController _mapController;
double _zoom = 10.0;

var heightS = 10.5;
Future<void> TapMove(LatLng latLng) async {
  await Future.delayed(Duration(seconds: 1));

  _mapController.move(LatLng(49.939048, 105.841644), _zoom + 2.5);
}

class FieldScreen extends StatefulWidget {
  FieldScreen({Key? key, this.tabController}) : super(key: key);
  PersistentTabController? tabController;
  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  List<Marker> markers = [];
  List<Marker> noteMarkers = [];
  LatLng firstLocation = LatLng(49.939048, 105.841644);
  List<LatLng> polygonPoints = [];
  List<Polygon> polygons = [];
  List<LatLng> currentPolygon = [];
  PanelController panelController = PanelController();
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
    final panelHeightClosed3 = MediaQuery.of(context).size.height * 0.18;
    final panelHeightClosed4 = MediaQuery.of(context).size.height * 0.265;

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.small(
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                        context: context,
                        builder: (BuildContext context) {
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
                                          onTap: () {
                                            setState(() {
                                              isMarker = true;
                                              isChoose = false;
                                              changeStage();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/common/note.png",
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Тэмдэглэл нэмэх'),
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
                                            setState(() {
                                              changePolygonStage();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Ink(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/common/area.png",
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Талбай зурах'),
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
                        });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                FloatingActionButton.small(
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
                      Globals.changeLatitude(latlng.latitude);
                      Globals.changeLongtitude(latlng.longitude);
                      setState(() {
                        _addMarkers(latlng);
                        polygonPoints.clear();
                      });
                    } else if (isChoose) {
                      setState(() {
                        Globals.changeLatitude(latlng.latitude);
                        Globals.changeLongtitude(latlng.longitude);
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
                  markers: noteMarkers,
                ),
                MarkerLayer(
                  markers: markers,
                ),
                PolylineLayer(
                  polylineCulling: true,
                  saveLayers: true,
                  polylines: [
                    Polyline(
                      points: polygonPoints,
                      color: Colors.white,

                      // useStrokeWidthInMeter: true,
                    ),
                  ],
                ),
                // TileLayer(
                //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                //   userAgentPackageName: 'com.example.app',
                // ),
                // PolygonLayer(
                //   polygons: polygons,
                //   // polygonCulling: true,
                // ),
              ],
            ),
            fieldAppBar(),
            Offstage(
                offstage: mapsol,
                child: Container(
                  height: 600,
                  child: PanelWidget(
                    controller: ScrollController(),
                  ),
              ),
            ),
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
                controller: panelController,
                backdropEnabled: true,
                maxHeight: panelHeightOpened2,
                minHeight: panelHeightClosed2,
                parallaxEnabled: true,
                parallaxOffset: .5,
                panelBuilder: (controller) => ListView(
                  controller: controller,
                  padding: EdgeInsets.zero,
                  children: [
                    NoteAdd(
                      success: () async {
                        await panelController.close();
                        markers.clear();
                        await getNoteMarkerList();
                        setState(() {});
                      },
                    ),
                  ],
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
                controller: panelController,
                backdropEnabled: true,
                maxHeight: panelHeightClosed3,
                minHeight: panelHeightClosed3,
                parallaxEnabled: true,
                parallaxOffset: .5,
                panelBuilder: (controller) => ListView(
                  controller: controller,
                  padding: EdgeInsets.zero,
                  children: [
                    AddField(
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
                      undo: () {
                        polygonPoints.removeLast();
                        setState(() {});
                      },
                      next: () {
                        isDetailAddFieldWidgetVisible = true;
                        setState(() {});
                      },
                    )
                  ],
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
            Offstage(
              offstage: !isDetailAddFieldWidgetVisible,
              child: SlidingUpPanel(
                backdropEnabled: true,
                maxHeight: MediaQuery.of(context).size.height * 0.81,
                minHeight: MediaQuery.of(context).size.height * 0.75,
                parallaxEnabled: true,
                onPanelClosed: () {},
                parallaxOffset: .5,
                panelBuilder: (controller) => ListView(
                  controller: controller,
                  padding: EdgeInsets.all(0),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildNavigator(),
                    ),
                    AddUnitAreaPage(
                      polygonPoints: polygonPoints,
                      back: () {
                        isDetailAddFieldWidgetVisible = false;
                        setState(() {});
                      },
                      success: () {
                        isDetailAddFieldWidgetVisible = false;
                        isAddFieldWidgetVisible = false;
                        setState(() {});
                      },
                    )
                  ],
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
            )
          ],
        ));
  }

  PreferredSize fieldAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(500.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SeasonChoicePage(
                  done: () {
                    getNoteMarkerList();
                  },
                  changeSeason: () {
                    noteMarkers.clear();
                    getNoteMarkerList();
                  },
                ),
          
            Column(
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
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
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

  getNoteMarkerList() {
    NoteService().getNoteList().then((value) {
      value.forEach((element) {
        noteMarkers.add(
          Marker(
              width: 10,
              height: 10,
              point: LatLng(double.parse(element.y_coordinate!), double.parse(element.x_coordinate!)),
              builder: (context) {
                return InkWell(
                  onTap: () {
                    _mapController.move(
                        LatLng(double.parse(element.y_coordinate!), double.parse(element.x_coordinate!)), 15);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    width: 10,
                    height: 10,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      });
      setState(() {});
    });
  }
}
