import 'dart:convert';

import '../conf_global.dart';
import '../models/crop.dart';
import 'commons/api_helper.dart';

class CropService {
  static Future<List<Crop>> getAllCrop() async {
    var response =
        await ApiHelper().getUrl(url: '/api/mobile/parcel/harvest/person_id?company_person_id=${Globals.personId}');
    List<Crop> crops = List<Crop>.from(json.decode(response).map((model) => Crop.fromJson(model)));
    return crops;
  }
}
