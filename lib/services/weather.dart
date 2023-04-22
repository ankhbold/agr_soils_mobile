import 'package:latlong2/latlong.dart';

import '../models/weather/weather.dart';
import 'commons/api_helper.dart';

class WeatherService {
  Future<Weather> getWeather({LatLng? latLng}) async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${latLng!.latitude}&lon=${latLng.longitude}&APPID=55240f0624f2de3ff8354fa9c1e75491';
    // print(url);
    final response = await ApiHelper().getUrl(url: url);
    return Weather.fromJson(response);
  }

  Future<List<Weather>> getForecastWeather({LatLng? latLng}) async {
    String url =
        'http://api.openweathermap.org/data/2.5/forecast?lat=${latLng!.latitude}&lon=${latLng.longitude}&APPID=55240f0624f2de3ff8354fa9c1e75491';
    // print(url);
    final response = await ApiHelper().getUrl(url: url);
    // print(response);
    List<Weather> weathers = List<Weather>.from(
      response['list'].map(
        (model) => Weather.fromJson(model),
      ),
    );
    return weathers;
  }
}
