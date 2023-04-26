// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parcel _$ParcelFromJson(Map<String, dynamic> json) => Parcel(
      id: json['id'] as int?,
      field_name: json['field_name'] as String?,
      parcel_season: (json['parcel_season'] as List<dynamic>?)
          ?.map((e) => ParcelSeason.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParcelToJson(Parcel instance) => <String, dynamic>{
      'id': instance.id,
      'field_name': instance.field_name,
      'parcel_season': instance.parcel_season,
    };
