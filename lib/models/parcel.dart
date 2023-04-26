import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm/models/parcel_season.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'parcel.g.dart';

@JsonSerializable()
class Parcel {
  int? id;
  String? field_name;
  List<ParcelSeason>? parcel_season;
  Parcel({
    this.id,
    this.field_name,
    this.parcel_season,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Parcel.fromJson(Map<String, dynamic> json) => _$ParcelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ParcelToJson(this);
}
