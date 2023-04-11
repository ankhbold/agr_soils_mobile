// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteType _$NoteTypeFromJson(Map<String, dynamic> json) => NoteType(
      id: json['id'] as int?,
      code: json['code'] as String?,
      is_active: json['is_active'] as bool?,
      name: json['name'] as String?,
      name_en: json['name_en'] as String?,
      description: json['description'] as String?,
      order_no: json['order_no'] as String?,
      parent_id: json['parent_id'] as int?,
      codelist_type: json['codelist_type'] as int?,
      codelist_comment: json['codelist_comment'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      created_by: json['created_by'] as String?,
      updated_by: json['updated_by'] as String?,
    )
      ..boundary_color = json['boundary_color'] as String?
      ..fill_color = json['fill_color'] as String?
      ..hover_color = json['hover_color'] as String?
      ..image_url = json['image_url'] as String?;

Map<String, dynamic> _$NoteTypeToJson(NoteType instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'is_active': instance.is_active,
      'name': instance.name,
      'name_en': instance.name_en,
      'description': instance.description,
      'order_no': instance.order_no,
      'parent_id': instance.parent_id,
      'codelist_type': instance.codelist_type,
      'codelist_comment': instance.codelist_comment,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_by': instance.created_by,
      'updated_by': instance.updated_by,
      'boundary_color': instance.boundary_color,
      'fill_color': instance.fill_color,
      'hover_color': instance.hover_color,
      'image_url': instance.image_url,
    };
