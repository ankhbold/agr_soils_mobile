import 'dart:convert';

import '../models/cultivation_type.dart';
import 'commons/api_helper.dart';

class CultivationService {
  static Future<List<CultivationType>> getCultivationType() async {
    var response = await ApiHelper().getUrl(url: '/api/mobile/cultivation/type');
    List<CultivationType> types =
        List<CultivationType>.from(json.decode(response).map((model) => CultivationType.fromJson(model)));

    return types;
  }
}
