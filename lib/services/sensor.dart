import 'dart:convert';

import 'package:mvvm/conf_global.dart';
import 'package:mvvm/models/sensor_info.dart';

import 'commons/api_helper.dart';

class SensorService {
  Future<List<SensorInfo>> getSensorList() async {
    var response = await ApiHelper().getUrl(url: '/api/mobile/sensor/get?company_person_id=${Globals.personId}');
    // print(response);
    List<SensorInfo> sensorInfos = List<SensorInfo>.from(
      (json.decode(response) as List).map(
        (model) => SensorInfo.fromJson(model),
      ),
    );

    return sensorInfos;
  }
}
