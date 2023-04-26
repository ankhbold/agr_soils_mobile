// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParcelSeason _$ParcelSeasonFromJson(Map<String, dynamic> json) => ParcelSeason(
      cult_name: json['cult_name'] as String?,
      fill_color: json['fill_color'] as String?,
      season_harvest_ha: json['season_harvest_ha'] as String?,
      parcel_harvest_ha: json['parcel_harvest_ha'] as String?,
      parcel_start_date: json['parcel_start_date'] as String?,
      parcel_end_date: json['parcel_end_date'] as String?,
    )
      ..season_id = json['season_id'] as int?
      ..season_name = json['season_name'] as String?;

Map<String, dynamic> _$ParcelSeasonToJson(ParcelSeason instance) =>
    <String, dynamic>{
      'season_id': instance.season_id,
      'season_name': instance.season_name,
      'cult_name': instance.cult_name,
      'fill_color': instance.fill_color,
      'season_harvest_ha': instance.season_harvest_ha,
      'parcel_harvest_ha': instance.parcel_harvest_ha,
      'parcel_start_date': instance.parcel_start_date,
      'parcel_end_date': instance.parcel_end_date,
    };
