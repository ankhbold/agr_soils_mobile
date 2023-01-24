import 'dart:convert';

import 'package:http/http.dart' as http;

const uri =
    'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247';
// Future<String> loadGeoJson(String uri) async {
//   try {
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//     final response = await http.get(Uri.parse(uri), headers: headers);
//     if (response.statusCode >= 400) {
//       throw Exception('statusCode=${response.statusCode}');
//     }
//     print(response.body);
//     return response.body;
//   } catch (e) {
//     print(e.toString());
//     return '';
//   }
// }

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future<dynamic> getGeo() async {
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        // Globals.changeJsonDataByCompany(returnGeoJson['name']);
        // print(Globals.getJsonDataByCompanyame());
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load json');
      }
    } catch (e) {
      print(e);
    }
  }
}
