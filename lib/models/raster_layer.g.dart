// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raster_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RasterLayer _$RasterLayerFromJson(Map<String, dynamic> json) => RasterLayer(
      name: json['name'] as String?,
      layer_name: json['layer_name'] as String?,
      column_name: json['column_name'] as String?,
    );

Map<String, dynamic> _$RasterLayerToJson(RasterLayer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'layer_name': instance.layer_name,
      'column_name': instance.column_name,
    };
