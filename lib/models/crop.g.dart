// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crop _$CropFromJson(Map<String, dynamic> json) => Crop(
      parcel_id: json['parcel_id'] as int?,
      cad_parcel_id: json['cad_parcel_id'] as String?,
      address_streetname: json['address_streetname'] as String?,
      field_name: json['field_name'] as String?,
      parcel_area_m2: json['parcel_area_m2'] as String?,
      parcel_area_ha: json['parcel_area_ha'] as String?,
      season_id: json['season_id'] as int?,
      season_name: json['season_name'] as String?,
      season_start_date: json['season_start_date'] as String?,
      season_end_date: json['season_end_date'] as String?,
      season_all_area_ha: json['season_all_area_ha'] as String?,
      season_harvest_ha: json['season_harvest_ha'] as String?,
      cult_names: json['cult_names'] as String?,
      fill_color: json['fill_color'] as String?,
      parcel_harvest_ha: json['parcel_harvest_ha'] as String?,
      parcel_end_date: json['parcel_end_date'] as String?,
    );

Map<String, dynamic> _$CropToJson(Crop instance) => <String, dynamic>{
      'parcel_id': instance.parcel_id,
      'cad_parcel_id': instance.cad_parcel_id,
      'address_streetname': instance.address_streetname,
      'field_name': instance.field_name,
      'parcel_area_m2': instance.parcel_area_m2,
      'parcel_area_ha': instance.parcel_area_ha,
      'season_id': instance.season_id,
      'season_name': instance.season_name,
      'season_start_date': instance.season_start_date,
      'season_end_date': instance.season_end_date,
      'season_all_area_ha': instance.season_all_area_ha,
      'season_harvest_ha': instance.season_harvest_ha,
      'cult_names': instance.cult_names,
      'fill_color': instance.fill_color,
      'parcel_harvest_ha': instance.parcel_harvest_ha,
      'parcel_end_date': instance.parcel_end_date,
    };
