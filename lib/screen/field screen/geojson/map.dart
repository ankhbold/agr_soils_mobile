// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:http/http.dart' as http;

// class MapBoxPage extends StatefulWidget {
//   const MapBoxPage({super.key});

//   @override
//   State<MapBoxPage> createState() => _MapBoxPageState();
// }

// class _MapBoxPageState extends State<MapBoxPage> {
//   late Future<GeoJsonData> _geoJsonData;

//   @override
//   void initState() {
//     super.initState();
//     _geoJsonData = fetchGeoJson();
//   }

//   Future<GeoJsonData> fetchGeoJson() async {
//     final response = await http.get(
//       Uri.parse(
//           'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247'),
//     );

//     if (response.statusCode == 200) {
//       return GeoJsonData(
//         data: json.decode(response.body),
//       );
//     } else {
//       throw Exception('Failed to load GeoJSON data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 33, 32, 32),
//         title: const Text('Flutter MapBox'),
//       ),
//       body: FutureBuilder<GeoJsonData>(
//         future: _geoJsonData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return MapboxMap(
//               accessToken: 'YOUR_ACCESS_TOKEN',
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.78825, -122.4324),
//                 zoom: 11.0,
//               ),
//               styleString: 'mapbox://styles/mapbox/light-v10',
//               geoJson: snapshot.data,
//               onMapCreated: (mapController) {},
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//       // MapboxMap(
//       //   accessToken:
//       //       'sk.eyJ1IjoiYW5raGJvbGQwMSIsImEiOiJjbGRpaDIwc2QwYThzM3ZxcGRpOXRzc3M5In0.oDJug09qGqDIVSIzrZFi1w',
//       //   initialCameraPosition:
//       //       CameraPosition(target: LatLng(49.946688, 105.806398), zoom: 12),
//       //   styleString: 'mapbox://styles/ankhbold01/cldiba59300b501r0ijd45bc9',
//       // ),
//     );
//   }
// }

// class GeoJsonData {
//   final dynamic data;

//   GeoJsonData({this.data});
// }
