import 'package:json_annotation/json_annotation.dart';

import '../coord.dart';
import 'clouds.dart';
import 'weather_element.dart';
import 'weather_main.dart';
import 'wind.dart';
part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather {
  Weather({
    this.coord,
    this.weather,
    this.main,
    this.visibility,
    this.wind,
    this.name,
    this.clouds,
  });

  final Coord? coord;
  final List<WeatherElement>? weather;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final String? name;
  final Clouds? clouds;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
