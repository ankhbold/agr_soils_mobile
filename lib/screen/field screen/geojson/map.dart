import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/geojson/get_geo_api.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class Mapss extends StatefulWidget {
  const Mapss({super.key});

  @override
  State<Mapss> createState() => _MapssState();
}

class _MapssState extends State<Mapss> {
  //sfmaps
  late MapShapeSource dataSource;
  late MapZoomPanBehavior _mapZoomPanBehavior;
  late MapLatLng _markerPosition;
  late MapTileLayerController _controller;
  int selectedIndex = 1;
  late List<Model> data;
  late List<dynamic> geoo;
//
  void _getGeoJson() async {
    NetworkHelper networkHelper = NetworkHelper(url: uri);
    var geoJson = await networkHelper.getGeo();
    if (geoJson != null) {
      setState(() {
        geoo = geoJson['properties'];
      });
    }
  }

  @override
  void initState() {
    _getGeoJson();

    data = <Model>[
      Model('Дунд ширээ 135 га',
          Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Хоёр даваа ', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 8 /16/ ha',
      //     Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 14', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Генерал толгой 1',
      //     Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Хоёр даваа 1', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Эрээн 6', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Баруун ширээ', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model(
      //     'Усалгаатай 10', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 1', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Шарилжит 2', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model(
      //     'Рашаант 243га', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Шарилжит 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 2', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 5', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 7 /312/',
      //     Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Рашаант 3', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Эрээн 10', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Эрээн 3', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Эрээн 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Эрээн 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Хутаг-Өндөр /2nd 10/',
      //     Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
      // Model('Мойлын ар 4', Color.fromARGB(255, 253, 213, 34).withOpacity(0.5)),
    ];
    _controller = MapTileLayerController();

    _mapZoomPanBehavior = MapZoomPanBehavior()
      ..focalLatLng = MapLatLng(49.987250, 105.785922)
      // ..maxZoomLevel
      // ..minZoomLevel
      ..enableDoubleTapZooming = true
      ..zoomLevel = 11;
    // ..onTap = updateMarkerChange;

    dataSource = MapShapeSource.network(
      'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247',
      shapeDataField: 'name',
      dataCount: geoo.length,
      primaryValueMapper: (int index) => data[index].name,
      shapeColorValueMapper: (int index) => data[index].color,
      // shapeColorMappers: shape
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapTileLayer(
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
            color: Color.fromARGB(255, 253, 213, 34).withOpacity(0.5),
            source: dataSource,
            strokeColor: Colors.white,
            strokeWidth: 1,
            selectionSettings: MapSelectionSettings(
              color: Colors.orange,
              strokeColor: Colors.red[900],
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
    );
  }
}

class Model {
  const Model(this.name, this.color);

  final String name;

  final Color color;
}
