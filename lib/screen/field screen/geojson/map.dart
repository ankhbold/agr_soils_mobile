import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/model/postModel.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_maps/maps.dart';

class Mapss extends StatefulWidget {
  const Mapss({super.key});

  @override
  State<Mapss> createState() => _MapssState();
}

class _MapssState extends State<Mapss> {
  late MapLatLng _markerPosition;
  var selectedIndex = 1;
  late MapShapeSource dataSource;

  late MapTileLayerController _controller;
  late List<PostModel> data = [];
  late MapZoomPanBehavior _mapZoomPanBehavior;
//

  @override
  void initState() {
    _controller = MapTileLayerController();
    fetch();

    _mapZoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(49.987250, 105.785922),
      enableDoubleTapZooming: true,
      zoomLevel: 11,
    );
    super.initState();
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
            Color.fromARGB(255, 253, 213, 34).withOpacity(0.5),
        // shapeColorMappers: shape
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);

    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapTileLayer(
            zoomPanBehavior: _mapZoomPanBehavior,
            controller: _controller,
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                  latitude: _markerPosition.latitude,
                  longitude: _markerPosition.longitude,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.transparent,
                    size: 30,
                  ));
            },
            initialFocalLatLng: MapLatLng(49.987250, 105.785922),
            initialZoomLevel: 12,
            urlTemplate:
                "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
            sublayers: [
              MapShapeSublayer(
                color: Color.fromARGB(255, 253, 213, 34).withOpacity(0.5),
                source: dataSource,
                strokeColor: Colors.white,
                strokeWidth: 1,
                selectionSettings: MapSelectionSettings(
                  color: Colors.white,
                  strokeColor: Color.fromARGB(255, 142, 255, 198),
                  strokeWidth: 3,
                ),
                selectedIndex: selectedIndex,
                onSelectionChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
