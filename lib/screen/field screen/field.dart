import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/screen/sensor/sensor_chart.dart';
import 'package:mvvm/services/satelite.dart';
import 'package:mvvm/services/sensor.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../conf_global.dart';
import '../../constants/color.dart';
import '../../models/get_satelite_info.dart';
import '../../models/note.dart';
import '../../services/geo_service.dart';
import '../../services/note_services.dart';
import '../../services/permissions/location.dart';
import '../../utils/date_manager.dart';
import '../../view_model/user_view_model.dart';
import '../../widget/loader.dart';
import '../../widget/snackbar.dart';
import '../field%20screen/floatingss/floating_items.dart';
import '../field%20screen/panel_widget.dart';
import '../field%20screen/satelite_image_type.dart';
import '../notes screen/add_note.dart';
import '../season/season_choice_page.dart';
import '../unit_area/add_area.dart';
import '../unit_area/add_unit_area_page.dart';
import '../unit_area/unit_areas.dart';
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
var sate;
var heightS = 10.5;
Future<void> TapMove(LatLng latLng) async {
  await Future.delayed(Duration(seconds: 1));

  _mapController.move(LatLng(49.939048, 105.841644), _zoom + 2.5);
}

Future<void> NoteMove(LatLng latLng) async {
  _mapController.move(latLng, _zoom + 5);
}

Future<void> UnitAreaMove(LatLng latLng) async {
  _mapController.move(latLng, _zoom + 5);
}

class FieldScreen extends StatefulWidget {
  FieldScreen({Key? key, this.tabController, this.isNoteSelected}) : super(key: key);
  PersistentTabController? tabController;
  bool? isNoteSelected;

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  List<Marker> markers = [];
  List<Marker> sensorLocations = [];
  List<String> sateliteDates = [];
  List<Marker> noteMarkers = [];
  LatLng firstLocation = LatLng(49.939048, 105.841644);
  List<LatLng> polygonPoints = [];
  List<Polygon> polygons = [];
  List<LatLng> currentPolygon = [];
  PanelController panelController = PanelController();
  String? currentLayerName, currentSateliteLayerName;
  Note? currentNote;

  int? currentUnitAreaNumber;
  var falseColor = '';
  static double fabHeightClosed = 90.0;
  double fabHeight = fabHeightClosed;
  var wmsLayer;

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
    if (Globals.isLogin) {
      SensorService().getSensorList().then((value) {
        sensorLocations.clear();
        value.forEach((element) {
          sensorLocations.add(
            Marker(
                width: 100,
                height: 100,
                point: LatLng(double.parse(element.y_coordinate!), double.parse(element.x_coordinate!)),
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ChartPage(
                          sensorDatas: [],
                        ),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                      // LoadingIndicator(context: context).showLoadingIndicator();
                      // SensorService().getSensorData(id: element.sensor_id).then((value) {
                      //   LoadingIndicator(context: context).hideLoadingIndicator();
                      //   if (value.isNotEmpty) {
                      //     PersistentNavBarNavigator.pushNewScreen(
                      //       context,
                      //       screen: ChartPage(
                      //         sensorDatas: value,
                      //       ),
                      //       withNavBar: true, // OPTIONAL VALUE. True by default.
                      //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      //     );
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                      //       message: "Сенсор мэдээлэл байхгүй байна",
                      //     ));
                      //   }

                      //   // print(value);
                      // }).catchError((onError) {
                      //   LoadingIndicator(context: context).hideLoadingIndicator();
                      // });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "сенсор" + " (${element.sensor_id.toString()})",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          child: Center(
                            child: Icon(
                              Icons.sensors,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
        setState(() {});
      });
    }
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
    final userPrefernece = Provider.of<UserViewModel>(context, listen: true);
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
            Globals.isLogin
                ? Column(
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
                  )
                : Container(),
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
                      Globals.changeSelectedUnitArea(null);
                      setState(() {
                        _addPolygons(latlng);
                        markers.clear();
                      });
                    } else if (isMarker) {
                      Globals.changeSelectedUnitArea(null);
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
                        Globals.changeSelectedUnitArea(null);
                        GeoService.getUnitAreaNumber(latLng: latlng).then(
                          (value) {
                            currentUnitAreaNumber = value.id;
                            setState(() {});
                            SateliteService().getSateliteDates(id: currentUnitAreaNumber).then((value) {
                              value.forEach((element) {
                                sateliteDates.add(element.image_date!);
                              });
                              setState(() {});
                            });
                          },
                        );
                        _handleTap(latlng);
                      });
                    }
                  });
                },
                center: firstLocation,
                zoom: _zoom,
              ),
              children: wmsLayer != null
                  ? [
                      tileLayer,
                      TileLayer(backgroundColor: Colors.transparent, wmsOptions: wmsLayer),
                      sate != null
                          ? TileLayer(
                              backgroundColor: Colors.transparent,
                              urlTemplate: sate,
                            )
                          : Container(),
                      MarkerLayer(
                        markers: noteMarkers,
                      ),
                      MarkerLayer(
                        markers: sensorLocations,
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
                          ),
                        ],
                      ),

                      // PolygonLayer(
                      //   polygons: polygons,
                      //   // polygonCulling: true,
                      // ),
                    ]
                  : [],
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: sateliteDates.map((e) {
                        return Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList()),
                  StateliteImageType(
                    changeSateliteLayer: (value) {
                      GetSateliteTypeInfo typeInfo = GetSateliteTypeInfo(
                        image_type: value,
                        parcel_id:
                            Globals.selectedUnitArea != null ? Globals.selectedUnitArea!.id : currentUnitAreaNumber,
                        sattelite_date: MyDateManager.toClientDateTime(
                            date: DateTime.now().subtract(Duration(days: 4)).toString(), noTime: true),
                      );
                      LoadingIndicator(context: context).showLoadingIndicator();
                      GeoService.getUnitAreaSateliteInfo(typeInfo: typeInfo).then((value) {
                        LoadingIndicator(context: context).hideLoadingIndicator();
                        if (value.status!) {
                          sate = value.image_url;

                          setState(() {});
                        }
                      }).catchError((onError) {
                        LoadingIndicator(context: context).hideLoadingIndicator();
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(
                            message: onError.toString(),
                          ),
                        );
                      });
                    },
                  ),
                  FloatingFab(
                    changeLayer: (layer) {
                      currentLayerName = layer.layer_name;
                      wmsLayer = WMSTileLayerOptions(
                        baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?',
                        layers: ['agrgis:${layer.layer_name}'],
                        transparent: true,
                        format: 'image/png',
                        version: '1.1.1',
                        otherParameters: {
                          'CQL_FILTER': 'person_id = ${Globals.personId} and season_id=${Globals.seasonId}',
                        },
                      );
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !isSecondWidgetVisible,
              child: SlidingUpPanel(
                controller: panelController,
                onPanelClosed: () {
                  Globals.changeSelectedNote(null);
                },
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
                      back: () {
                        isSecondWidgetVisible = false;
                        setState(() {});
                      },
                      success: () async {
                        await panelController.close();
                        markers.clear();
                        noteMarkers.clear();
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
                        wmsLayer = WMSTileLayerOptions(
                          baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?',
                          layers: ['agrgis:${currentLayerName}'],
                          transparent: true,
                          format: 'image/png',
                          version: '1.1.1',
                          otherParameters: {
                            'CQL_FILTER': 'person_id = ${Globals.personId} and season_id=${Globals.seasonId}',
                          },
                        );
                        polygonPoints.clear();
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

  getNoteMarkerList() {
    NoteService().getNoteList().then((value) {
      value.forEach((element) {
        noteMarkers.add(
          Marker(
              width: 15,
              height: 15,
              point: LatLng(double.parse(element.y_coordinate!), double.parse(element.x_coordinate!)),
              builder: (context) {
                return InkWell(
                  onTap: () {
                    LoadingIndicator(context: context).showLoadingIndicator();
                    NoteService().getNoteDetail(id: element.id).then((value) {
                      LoadingIndicator(context: context).hideLoadingIndicator();

                      currentNote = value;
                      // print(currentNote!.images.toString());
                      isSecondWidgetVisible = true;
                      Globals.changeSelectedNote(currentNote);
                      _mapController.move(
                          LatLng(double.parse(element.y_coordinate!), double.parse(element.x_coordinate!)), 15);
                      setState(() {});
                    }).catchError((onError) {
                      LoadingIndicator(context: context).hideLoadingIndicator();
                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                        message: onError.toString(),
                      ));
                    });
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
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.blue,
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
              done: () async {
                noteMarkers.clear();
                await getNoteMarkerList();
                currentLayerName = 'agr_parcel';
                wmsLayer = Globals.isLogin
                    ? WMSTileLayerOptions(
                        baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms?',
                        layers: ['agrgis:agr_parcel'],
                        transparent: true,
                        format: 'image/png',
                        version: '1.1.1',
                        otherParameters: {
                          'CQL_FILTER': 'person_id = ${Globals.personId} and season_id=${Globals.seasonId}',
                        },
                      )
                    : WMSTileLayerOptions(baseUrl: 'http://103.143.40.250:8080/geoserver/agrgis/wms');
                setState(() {});
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(),
                            body: AllUnitAreas(
                              isAll: true,
                            ),
                          ),
                        ),
                      );
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
}
