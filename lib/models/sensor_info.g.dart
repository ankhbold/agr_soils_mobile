// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorInfo _$SensorInfoFromJson(Map<String, dynamic> json) => SensorInfo(
      sensor_id: json['sensor_id'] as int?,
      sensor_serial: json['sensor_serial'] as String?,
      s_version: json['s_version'] as String?,
      last_connection: json['last_connection'] as String?,
      device_version: json['device_version'] as String?,
      installed_at: json['installed_at'] as String?,
      coordinate_id: json['coordinate_id'] as int?,
      x_coordinate: json['x_coordinate'] as String?,
      y_coordinate: json['y_coordinate'] as String?,
    );

Map<String, dynamic> _$SensorInfoToJson(SensorInfo instance) =>
    <String, dynamic>{
      'sensor_id': instance.sensor_id,
      'sensor_serial': instance.sensor_serial,
      's_version': instance.s_version,
      'last_connection': instance.last_connection,
      'device_version': instance.device_version,
      'installed_at': instance.installed_at,
      'coordinate_id': instance.coordinate_id,
      'x_coordinate': instance.x_coordinate,
      'y_coordinate': instance.y_coordinate,
    };
