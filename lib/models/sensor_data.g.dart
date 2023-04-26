// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorData _$SensorDataFromJson(Map<String, dynamic> json) => SensorData(
      unix_datetime: json['unix_datetime'] as String?,
      id: json['id'] as int?,
      air_moisture: json['air_moisture'] as String?,
      air_moisture_secondary: json['air_moisture_secondary'] as String?,
      air_temp: json['air_temp'] as String?,
      air_temp_secondary: json['air_temp_secondary'] as String?,
      coordinate_id: json['coordinate_id'] as String?,
      battery: json['battery'] as String?,
      datetime: json['datetime'] as String?,
      dew_point: json['dew_point'] as String?,
      luminance: json['luminance'] as String?,
      moisture: json['moisture'] as String?,
      moisture_secondary: json['moisture_secondary'] as String?,
      raw_air_pressure: json['raw_air_pressure'] as String?,
      raw_air_pressure_secondary: json['raw_air_pressure_secondary'] as String?,
      raw_moisture: json['raw_moisture'] as String?,
      raw_moisture_secondary: json['raw_moisture_secondary'] as String?,
      temp: json['temp'] as String?,
      temp_secondary: json['temp_secondary'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      created_by: json['created_by'] as String?,
      updated_by: json['updated_by'] as String?,
    );

Map<String, dynamic> _$SensorDataToJson(SensorData instance) =>
    <String, dynamic>{
      'unix_datetime': instance.unix_datetime,
      'id': instance.id,
      'air_moisture': instance.air_moisture,
      'air_moisture_secondary': instance.air_moisture_secondary,
      'air_temp': instance.air_temp,
      'air_temp_secondary': instance.air_temp_secondary,
      'battery': instance.battery,
      'coordinate_id': instance.coordinate_id,
      'datetime': instance.datetime,
      'dew_point': instance.dew_point,
      'luminance': instance.luminance,
      'moisture': instance.moisture,
      'moisture_secondary': instance.moisture_secondary,
      'raw_air_pressure': instance.raw_air_pressure,
      'raw_air_pressure_secondary': instance.raw_air_pressure_secondary,
      'raw_moisture': instance.raw_moisture,
      'raw_moisture_secondary': instance.raw_moisture_secondary,
      'temp': instance.temp,
      'temp_secondary': instance.temp_secondary,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_by': instance.created_by,
      'updated_by': instance.updated_by,
    };
