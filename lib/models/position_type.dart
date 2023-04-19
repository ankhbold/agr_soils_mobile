import 'package:json_annotation/json_annotation.dart';

part 'position_type.g.dart';

@JsonSerializable()
class PositionType {
  int? id;
  String? name;
  String? description;
  String? created_at;
  dynamic created_by;
  String? updated_at;
  dynamic updated_by;

  PositionType({
    this.id,
    this.name,
    this.description,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory PositionType.fromJson(Map<String, dynamic> json) => _$PositionTypeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PositionTypeToJson(this);
}
