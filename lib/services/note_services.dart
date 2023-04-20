import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm/services/commons/api_helper.dart';

import '../conf_global.dart';
import '../models/create_note_request.dart';
import '../models/note.dart';
import '../models/note_type.dart';

// const uri = 'https://63aa6bd6594f75dc1dcff51c.mockapi.io/name';
// const uri2 = 'http://103.143.40.250:8100/api/get/season';
const uri3 = 'http://103.143.40.250:8100/api/note/type/getnotetype';
const uri4 = 'http://103.143.40.250:8100/api/note/post/store';
const uri5 = 'http://103.143.40.250:8100/api/note/delete';
const uri6 = 'http://103.143.40.250:8100/api/note/update';

class NoteService {
  Future getGetNoteType() async {
    try {
      final response = await http.get(
          // Uri.parse('https://63aa6bd6594f75dc1dcff51c.mockapi.io/name'));
          Uri.parse(uri3));

      // var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);

        List<NoteType> note = it.map((e) => NoteType.fromJson(e)).toList();
        return note;
      } else {
        throw Exception('fail');
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future createNoteStore(CreateNoteRequestModel createNoteRequestModel) async {
    final response = await ApiHelper().postUrl(
        url:
            '/api/mobile/parcelnote/create?season_id=${createNoteRequestModel.season_id}&description=${createNoteRequestModel.description}desc&note_type=${createNoteRequestModel.note_type}&cordinate_x=${createNoteRequestModel.cordinate_x}&cordinate_y=${createNoteRequestModel.cordinate_y}&send_date=${createNoteRequestModel.send_date}&files=${createNoteRequestModel.files}');
    return response;
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

  Future<List<Note>> getNoteList({String? person_id, String? season_id}) async {
    // print(Globals.seasonId);
    String urlList =
        'http://103.143.40.250:8100/api/mobile/getnotes?company_person_id=${Globals.personId}&season_id=${Globals.seasonId}';
    var url = Uri.parse(urlList);
    List<Note> notes = [];
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        notes = data.map((e) => Note.fromJson(e)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return notes;
  }

  Future deleteNote(int id) async {
    String uri5 = 'http://103.143.40.250:8100/api/mobile/parcelnote/delete?note_id=$id';
    try {
      final response = await http.delete(
        Uri.parse('$uri5'),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
