import 'dart:convert';

import '../conf_global.dart';
import '../models/sensor_data.dart';
import '../models/sensor_info.dart';
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

  Future<List<SensorData>> getSensorData({int? id, String? start_date, String? end_date}) async {
    var response = await ApiHelper()
        .getUrl(url: '/api/mobile/sensor/data/id?sensor_id=${id}&start_date=$start_date&end_date=$end_date');
      List<SensorData> sensorDatas = List<SensorData>.from(
        (json.decode(response) as List).map(
          (model) => SensorData.fromJson(model),
        ),
      );
    return sensorDatas; 
  }
}
