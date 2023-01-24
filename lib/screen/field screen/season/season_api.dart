import 'dart:convert';

import 'package:http/http.dart' as http;

const uri =
    'http://103.143.40.250:8100/api/get/season/profcompany?prof_company_id=1';
const uri2 = 'http://103.143.40.250:8100/api/get/season';
const uri3 = 'http://103.143.40.250:8100/api/note/type/getnotetype';
const uri4 = 'http://103.143.40.250:8100/api/note/post/store';
const uri5 = 'http://103.143.40.250:8100/api/note/delete';
const uri6 = 'http://103.143.40.250:8100/api/note/update';

class RepositorySeason {
  late final String url;

  RepositorySeason({required this.url});

  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }
}
