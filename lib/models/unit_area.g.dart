// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitArea _$UnitAreaFromJson(Map<String, dynamic> json) => UnitArea(
      type: json['type'] as String?,
      id: json['id'] as String?,
      properties: json['properties'] == null
          ? null
          : UnitAreaProperties.fromJson(
              json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitAreaToJson(UnitArea instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'properties': instance.properties?.toJson(),
    };
