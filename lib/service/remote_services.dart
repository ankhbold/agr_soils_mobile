import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm/service/apis/get_notes_data.dart';

// const uri = 'https://63aa6bd6594f75dc1dcff51c.mockapi.io/name';
// const uri2 = 'http://103.143.40.250:8100/api/get/season';
const uri3 = 'http://103.143.40.250:8100/api/note/type/getnotetype';
const uri4 = 'http://103.143.40.250:8100/api/note/post/store';
const uri5 = 'http://103.143.40.250:8100/api/note/delete';
const uri6 = 'http://103.143.40.250:8100/api/note/update';

class Repository {
  Future getGetNoteApi() async {
    try {
      final response = await http.get(
          // Uri.parse('https://63aa6bd6594f75dc1dcff51c.mockapi.io/name'));
          Uri.parse(uri3));

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

  Future createData(
    String name,
  ) async {
    try {
      final response = await http.post(
          Uri.parse('http://103.143.40.250:8100/api/note/post/store'),
          body: {
            'name': name,
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future updatePage(String id, String name, String nameEn) async {
    try {
      final response = await http.put(
        Uri.parse('$uri6/$id'),
        body: {
          'name': name,
          'name_en': nameEn,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteData(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$uri5/$id'),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
