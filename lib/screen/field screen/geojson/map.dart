import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;
import '../../../model/postModel.dart';

class MapBoxPage extends StatefulWidget {
  const MapBoxPage({Key? key}) : super(key: key);
  @override
  State<MapBoxPage> createState() => _MapBoxPageState();
}

class _MapBoxPageState extends State<MapBoxPage> {
  LatLng firstLocation = LatLng(50.028372, 105.817248);
  var sate =
      'http://api.agromonitoring.com/image/1.0/10063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
  var png =
      'http://api.agromonitoring.com/image/1.0/10063c34200/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b';
  var pngs =
      "http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b";
  // var dataJson = Globals.jsonDataByCompanyId;
//sfmaps
  late MapLatLng _markerPosition;
  var selectedIndex = -1;
  late MapShapeSource dataSource;
  // late MapZoomPanBehavior _mapZoomPanBehavior;
  late _CustomZoomPanBehavior _mapZoomPanBehavior;
  // late MapZoomPanBehavior _mapBehavior;
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

  // void _navigateToPosition() {
  //   _determinePosition().then((value) => _mapZoomPanBehavior.focalLatLng =
  //       MapLatLng(value.latitude, value.longitude));
  // }

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
        body: Stack(children: [
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
              MapShapeSublayer(
                // showDataLabels: true,
                dataLabelSettings: MapDataLabelSettings(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflowMode: MapLabelOverflow.visible,
                ),
                source: dataSource,
                strokeColor: Colors.white.withOpacity(0.5),
                strokeWidth: 2,
                selectedIndex: selectedIndex,
                selectionSettings: MapSelectionSettings(
                  strokeWidth: 2,
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                  strokeColor: Color.fromARGB(255, 255, 255, 255),
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
          MapTileLayer(
              urlTemplate:
                  'http://api.agromonitoring.com/tile/1.0/{z}/{x}/{y}/10063b8b600/63bbe6a99512edd85de62fcf?appid=515ebec1b32cec8d92b4de210361642b'),
        ],
      ),
    ]));
  }
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
