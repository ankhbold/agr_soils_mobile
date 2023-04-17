// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherElement _$WeatherElementFromJson(Map<String, dynamic> json) =>
    WeatherElement(
      id: json['id'] as int?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherElementToJson(WeatherElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icon': instance.icon,
    };
