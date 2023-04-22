// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int?,
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      name: json['name'] as String?,
      clouds: json['clouds'] == null
          ? null
          : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      dt_txt: json['dt_txt'] as String?,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'coord': instance.coord?.toJson(),
      'weather': instance.weather?.map((e) => e.toJson()).toList(),
      'main': instance.main?.toJson(),
      'visibility': instance.visibility,
      'wind': instance.wind?.toJson(),
      'name': instance.name,
      'clouds': instance.clouds?.toJson(),
      'dt_txt': instance.dt_txt,
    };
