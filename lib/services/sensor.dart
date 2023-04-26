import 'dart:convert';

import 'package:mvvm/conf_global.dart';
import 'package:mvvm/models/sensor_info.dart';

import '../models/sensor_data.dart';
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

  Future<List<SensorData>> getSensorData({int? id}) async {
    var response = await ApiHelper().getUrl(url: '/api/mobile/sensor/data/id?sensor_id=$id');
    // print(response);
    try {
      List<SensorData> sensorDatas = List<SensorData>.from(
        (json.decode(response) as List).map(
          (model) => SensorData.fromJson(model),
        ),
      );
      return sensorDatas;
    } catch (Ex) {
      print(Ex.toString());
      return [];
    }
  }
}
