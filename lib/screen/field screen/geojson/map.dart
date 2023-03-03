import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WmsScreen extends StatefulWidget {
  const WmsScreen({Key? key}) : super(key: key);

  @override
  _WmsScreenState createState() => _WmsScreenState();
}

class _WmsScreenState extends State<WmsScreen> {
  late Map<String, dynamic> _wmsResponse;

  @override
  void initState() {
    super.initState();
    _fetchWmsResponse();
  }

  Future<void> _fetchWmsResponse() async {
    final url = Uri.parse(
        'http://103.143.40.250:8080/geoserver/agrgis/wms?service=WMS&version=1.3.0&request=GetFeatureInfo&layers=agrgis:layername&styles=&format=image/png&transparent=true&height=512&width=512&query_layers=agrgis:layername&info_format=application/json&i=256&j=256&bbox=95.0300,-11.0070,141.0210,6.2775&crs=EPSG:4326');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _wmsResponse = json.decode(response.body);
      });
      print(_wmsResponse['features'][0]['geometry']);
    } else {
      throw Exception('Failed to fetch WMS response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WMS Screen'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
