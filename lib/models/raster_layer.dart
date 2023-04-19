import 'package:json_annotation/json_annotation.dart';

part 'raster_layer.g.dart';

@JsonSerializable()
class RasterLayer {
  String? name;
  String? layer_name;
  String? column_name;
  RasterLayer({this.name, this.layer_name, this.column_name});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RasterLayer.fromJson(Map<String, dynamic> json) => _$RasterLayerFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RasterLayerToJson(this);
}
