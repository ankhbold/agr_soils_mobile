// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_area_satelite_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAreaSateliteInfo _$UnitAreaSateliteInfoFromJson(
        Map<String, dynamic> json) =>
    UnitAreaSateliteInfo(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      image_url: json['image_url'] as String?,
      bbox: json['bbox'] as String?,
      stats: json['stats'] == null
          ? null
          : UnitAreaSateliteInfoStats.fromJson(
              json['stats'] as Map<String, dynamic>),
      image_type: json['image_type'] as String?,
    );

Map<String, dynamic> _$UnitAreaSateliteInfoToJson(
        UnitAreaSateliteInfo instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'image_url': instance.image_url,
      'bbox': instance.bbox,
      'stats': instance.stats?.toJson(),
      'image_type': instance.image_type,
    };
