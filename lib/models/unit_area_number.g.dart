// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_area_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAreaNumber _$UnitAreaNumberFromJson(Map<String, dynamic> json) =>
    UnitAreaNumber(
      id: json['id'] as int?,
      cad_parcel_id: json['cad_parcel_id'] as String?,
      api_parcel_id: json['api_parcel_id'] as String?,
    );

Map<String, dynamic> _$UnitAreaNumberToJson(UnitAreaNumber instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cad_parcel_id': instance.cad_parcel_id,
      'api_parcel_id': instance.api_parcel_id,
    };
