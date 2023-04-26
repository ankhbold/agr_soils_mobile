// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crop _$CropFromJson(Map<String, dynamic> json) => Crop(
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      parcels: (json['parcels'] as List<dynamic>?)
          ?.map((e) => Parcel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CropToJson(Crop instance) => <String, dynamic>{
      'seasons': instance.seasons,
      'parcels': instance.parcels,
    };
