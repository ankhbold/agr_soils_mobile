import 'package:json_annotation/json_annotation.dart';

import 'unit_geometry.dart';
import 'unit_properties.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'unit_area.g.dart';

@JsonSerializable(explicitToJson: true)
class UnitArea {
  String? type;
  String? id;
  UnitAreaProperties? properties;
  // UnitAreaGeometry? geometry;
  UnitArea({
    this.type,
    this.id,
    this.properties,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UnitArea.fromJson(Map<String, dynamic> json) => _$UnitAreaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UnitAreaToJson(this);
}
