import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'season.g.dart';

@JsonSerializable()
class Season {
  int? season_id;
  String? season_name;
  String? description;
  String? start_date;
  String? end_date;
  int? prof_company_id;
  Season({this.season_id, this.season_name, this.description, this.start_date, this.end_date, this.prof_company_id});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}
