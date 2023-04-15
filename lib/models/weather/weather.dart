import 'package:json_annotation/json_annotation.dart';

import '../coord.dart';
import 'weather_element.dart';
import 'weather_main.dart';
import 'wind.dart';

@JsonSerializable(explicitToJson: true)
class Weather {
  Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
  });

  final Coord coord;
  final List<WeatherElement> weather;
  final Main main;
  final int visibility;
  final Wind wind;
  final String name;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: Coord.fromJson(json["coord"]),
        weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "name": name,
      };
}
