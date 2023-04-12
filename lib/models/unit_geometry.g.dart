// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAreaGeometry _$UnitAreaGeometryFromJson(Map<String, dynamic> json) =>
    UnitAreaGeometry(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList())
              .toList())
          .toList(),
    );

Map<String, dynamic> _$UnitAreaGeometryToJson(UnitAreaGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
