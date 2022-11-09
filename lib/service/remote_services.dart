import 'package:http/http.dart' as http;

import 'apis/get_notes_data.dart';

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse(
      'http://103.143.40.250:8100/api/parcel/parcelnote/store?description=%27test%27&x_coordinate=105.665262&x_coordinate=149.950589&y_coordinate=49.950589&note_date=2022-11-07',
    );
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
    return null;
  }
}
