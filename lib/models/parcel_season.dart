import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'parcel_season.g.dart';

@JsonSerializable()
class ParcelSeason {
  int? season_id;
  String? season_name;
  String? cult_name;
  String? fill_color;
  String? season_harvest_ha;
  String? parcel_harvest_ha;
  String? parcel_start_date;
  String? parcel_end_date;

  ParcelSeason({
    this.cult_name,
    this.fill_color,
    this.season_harvest_ha,
    this.parcel_harvest_ha,
    this.parcel_start_date,
    this.parcel_end_date,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ParcelSeason.fromJson(Map<String, dynamic> json) => _$ParcelSeasonFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ParcelSeasonToJson(this);
}
