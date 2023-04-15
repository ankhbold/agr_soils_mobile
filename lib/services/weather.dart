import 'dart:convert';

import 'package:latlong2/latlong.dart';

import '../models/weather/weather.dart';
import 'commons/api_helper.dart';

class WeatherService {
  Future<Weather> getWeather({LatLng? latLng}) async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${latLng!.latitude}&lon=${latLng.longitude}&APPID=6adf87802066a3ee22591eb3f8abfe0c';
    final response = await ApiHelper().getUrl(url: url);
    return Weather.fromJson(json.decode(response));
  }
}
