import 'dart:convert';

import '../conf_global.dart';
import '../models/crop.dart';
import 'commons/api_helper.dart';

class CropService {
  static Future<Crop> getAllCrop() async {
    var response = await ApiHelper().getUrl(
        url:
            '/api/mobile/parcel/harvest/person_id?company_person_id=${Globals.personId}&pro_company_id=${Globals.prof_company_id}');

    Crop crop = Crop.fromJson(response);
    return crop;
  }
}
