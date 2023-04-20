import 'package:json_annotation/json_annotation.dart';

part 'satelite_layer_type.g.dart';

@JsonSerializable()
class SateliteLayerType {
  String? name;
  String? description;
  SateliteLayerType({
    this.name,
    this.description,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SateliteLayerType.fromJson(Map<String, dynamic> json) => _$SateliteLayerTypeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SateliteLayerTypeToJson(this);
}
