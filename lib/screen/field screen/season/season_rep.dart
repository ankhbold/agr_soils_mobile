import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model_season.dart';

final uri = 'http://103.143.40.250:8100/api/get/season';

class RepositoryS {
  Future getSeasonApi() async {
    try {
      final response = await http.get(
          // Uri.parse('https://63aa6bd6594f75dc1dcff51c.mockapi.io/name'));
          Uri.parse(uri));

      // var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<SeasonModel> seasons =
            it.map((e) => SeasonModel.fromJson(e)).toList();
        return seasons;
      } else {
        throw Exception('fail');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
