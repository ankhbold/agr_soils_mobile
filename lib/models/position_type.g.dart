// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionType _$PositionTypeFromJson(Map<String, dynamic> json) => PositionType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      created_at: json['created_at'] as String?,
      created_by: json['created_by'],
      updated_at: json['updated_at'] as String?,
      updated_by: json['updated_by'],
    );

Map<String, dynamic> _$PositionTypeToJson(PositionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.created_at,
      'created_by': instance.created_by,
      'updated_at': instance.updated_at,
      'updated_by': instance.updated_by,
    };
