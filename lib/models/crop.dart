import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'crop.g.dart';

@JsonSerializable()
class Crop {
  int? parcel_id;
  String? cad_parcel_id;
  String? address_streetname;
  String? field_name;
  String? parcel_area_m2;
  String? parcel_area_ha;
  int? season_id;
  String? season_name;
  String? season_start_date;
  String? season_end_date;
  String? season_all_area_ha;
  String? season_harvest_ha;
  String? cult_names;
  String? fill_color;
  String? parcel_harvest_ha;
  String? parcel_end_date;

  Crop({
    this.parcel_id,
    this.cad_parcel_id,
    this.address_streetname,
    this.field_name,
    this.parcel_area_m2,
    this.parcel_area_ha,
    this.season_id,
    this.season_name,
    this.season_start_date,
    this.season_end_date,
    this.season_all_area_ha,
    this.season_harvest_ha,
    this.cult_names,
    this.fill_color,
    this.parcel_harvest_ha,
    this.parcel_end_date,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Crop.fromJson(Map<String, dynamic> json) => _$CropFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CropToJson(this);
}
