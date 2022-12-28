import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm/service/apis/get_notes_data.dart';

class Repository {
  Future getGetNoteApi() async {
    try {
      final response = await http.get(
          // Uri.parse('http://103.143.40.250:8100/api/note/type/getnotetype'));
          Uri.parse('http://103.143.40.250:8100/api/note/type/getnotetype'));

      // var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<GetNote> note = it.map((e) => GetNote.fromJson(e)).toList();
        return note;
      } else {
        throw Exception('fail');
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future createData(String name, String nameEn) async {
    try {
      final response = await http.post(
          Uri.parse('http://103.143.40.250:8100/api/note/post/store'),
          body: {'name': name, 'name_en': nameEn});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
