import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchSate() async {
  final response = await http
      .get(Uri.parse('http://103.143.40.250:8100/api/getparcel/latlong?coord_x=105.676697&coord_y=49.725946'));
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    if (responseJson['status'] == true) {
      final data = json.decode(responseJson['data']);
      print(data);
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}
