// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_area_satelite_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitAreaSateliteInfoStats _$UnitAreaSateliteInfoStatsFromJson(
        Map<String, dynamic> json) =>
    UnitAreaSateliteInfoStats(
      std: (json['std'] as num?)?.toDouble(),
      p25: (json['p25'] as num?)?.toDouble(),
      num: (json['num'] as num?)?.toDouble(),
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      median: (json['median'] as num?)?.toDouble(),
      p75: (json['p75'] as num?)?.toDouble(),
      mean: (json['mean'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UnitAreaSateliteInfoStatsToJson(
        UnitAreaSateliteInfoStats instance) =>
    <String, dynamic>{
      'std': instance.std,
      'p25': instance.p25,
      'num': instance.num,
      'min': instance.min,
      'max': instance.max,
      'median': instance.median,
      'p75': instance.p75,
      'mean': instance.mean,
    };
