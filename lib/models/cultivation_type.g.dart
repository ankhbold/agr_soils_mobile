// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultivation_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CultivationType _$CultivationTypeFromJson(Map<String, dynamic> json) =>
    CultivationType(
      id: json['id'] as int?,
      code: json['code'] as String?,
      is_active: json['is_active'] as bool?,
      name: json['name'] as String?,
      name_en: json['name_en'] as String?,
      description: json['description'] as String?,
      order_no: json['order_no'] as int?,
      parent_id: json['parent_id'] as int?,
      codelist_type: json['codelist_type'] as int?,
      codelist_comment: json['codelist_comment'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      created_by: json['created_by'] as String?,
      updated_by: json['updated_by'] as String?,
      h_formula: json['h_formula'],
      inter_no: json['inter_no'],
      start_year: json['start_year'],
      boundary_width: json['boundary_width'],
      boundary_color: json['boundary_color'] as String?,
      fill_color: json['fill_color'] as String?,
      hover_color: json['hover_color'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$CultivationTypeToJson(CultivationType instance) =>
    <String, dynamic>{
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
      'h_formula': instance.h_formula,
      'inter_no': instance.inter_no,
      'start_year': instance.start_year,
      'boundary_width': instance.boundary_width,
      'boundary_color': instance.boundary_color,
      'fill_color': instance.fill_color,
      'hover_color': instance.hover_color,
      'image_url': instance.image_url,
    };
