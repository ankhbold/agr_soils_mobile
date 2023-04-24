import 'package:json_annotation/json_annotation.dart';

import 'unit_geometry.dart';
import 'unit_properties.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'unit_area.g.dart';

@JsonSerializable(explicitToJson: true)
class UnitArea {
  int? id;
  String? cad_parcel_id;
  String? address_streetname;
  String? field_name;
  int? agr_cultivation_id;
  String? area_m2;
  String? area_ha;
  String? parcel_image;
  String? coord_x;
  String? coord_y;
  String? cult_names;
  String? parcel_ndvi;
  String? parcel_end_date;
  // UnitAreaGeometry? geometry;
  UnitArea({
    this.id,
    this.cad_parcel_id,
    this.address_streetname,
    this.field_name,
    this.agr_cultivation_id,
    this.area_m2,
    this.area_ha,
    this.parcel_image,
    this.coord_x,
    this.coord_y,
    this.cult_names,
    this.parcel_ndvi,
    this.parcel_end_date,
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
