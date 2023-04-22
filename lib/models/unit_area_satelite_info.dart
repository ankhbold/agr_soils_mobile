import 'package:json_annotation/json_annotation.dart';

import 'unit_area_satelite_stats.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'unit_area_satelite_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UnitAreaSateliteInfo {
  bool? status;
  String? message;
  String? image_url;
  String? bbox;
  UnitAreaSateliteInfoStats? stats;
  String? image_type;

  UnitAreaSateliteInfo({
    this.status,
    this.message,
    this.image_url,
    this.bbox,
    this.stats,
    this.image_type,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UnitAreaSateliteInfo.fromJson(Map<String, dynamic> json) => _$UnitAreaSateliteInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UnitAreaSateliteInfoToJson(this);
}
