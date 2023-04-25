import 'dart:convert';

import 'package:mvvm/models/satelite_date.dart';
import 'package:mvvm/models/satelite_layer_type.dart';
import 'package:mvvm/services/commons/api_helper.dart';

class SateliteService {
  Future<List<SateliteLayerType>> getSateliteTypes() async {
    var url = 'http://103.143.40.250:8100/api/mobile/satellite/imagetype';
    final response = await ApiHelper().getUrl(url: url);
    List<SateliteLayerType> types = (response as List).map((e) => SateliteLayerType.fromJson(e)).toList();
    return types;
  }

  Future<List<SateliteDate>> getSateliteDates({int? id}) async {
    final response = await ApiHelper().getUrl(url: '/parcel/satellite/date/byparcelid?parcel_id=$id');
    List<SateliteDate> dates = (json.decode(response) as List).map((e) => SateliteDate.fromJson(e)).toList();
    return dates;
  }
}
