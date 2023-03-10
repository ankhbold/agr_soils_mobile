import 'dart:convert';

import 'package:http/http.dart' as http;

const uri =
    'http://103.143.40.250:8100/mobile/parcel/jsondata/by/person_id?company_person_id=626247';

class GeoRepository {
  Future<void> makeGetRequest() async {
    // Make the GET request
    var response = await http.get(Uri.parse(uri));

    // Parse the JSON data
    var data = json.decode(response.body);

    // Print the desired parameter
    // print(data['title']);
    return data;
  }
}
