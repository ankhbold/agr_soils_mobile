// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitArea _$UnitAreaFromJson(Map<String, dynamic> json) => UnitArea(
      id: json['id'] as int?,
      cad_parcel_id: json['cad_parcel_id'] as String?,
      address_streetname: json['address_streetname'] as String?,
      field_name: json['field_name'] as String?,
      agr_cultivation_id: json['agr_cultivation_id'] as int?,
      area_m2: json['area_m2'] as String?,
      area_ha: json['area_ha'] as String?,
      parcel_image: json['parcel_image'] as String?,
      coord_x: json['coord_x'] as String?,
      coord_y: json['coord_y'] as String?,
      cult_names: json['cult_names'] as String?,
    );

Map<String, dynamic> _$UnitAreaToJson(UnitArea instance) => <String, dynamic>{
      'id': instance.id,
      'cad_parcel_id': instance.cad_parcel_id,
      'address_streetname': instance.address_streetname,
      'field_name': instance.field_name,
      'agr_cultivation_id': instance.agr_cultivation_id,
      'area_m2': instance.area_m2,
      'area_ha': instance.area_ha,
      'parcel_image': instance.parcel_image,
      'coord_x': instance.coord_x,
      'coord_y': instance.coord_y,
      'cult_names': instance.cult_names,
    };
