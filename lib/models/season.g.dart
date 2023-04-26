// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      season_id: json['season_id'] as int?,
      season_name: json['season_name'] as String?,
      description: json['description'] as String?,
      start_date: json['start_date'] as String?,
      end_date: json['end_date'] as String?,
      prof_company_id: json['prof_company_id'] as int?,
      season_all_area_ha: json['season_all_area_ha'] as String?,
      season_harvest_ha: json['season_harvest_ha'] as String?,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'season_id': instance.season_id,
      'season_name': instance.season_name,
      'description': instance.description,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'prof_company_id': instance.prof_company_id,
      'season_all_area_ha': instance.season_all_area_ha,
      'season_harvest_ha': instance.season_harvest_ha,
    };
