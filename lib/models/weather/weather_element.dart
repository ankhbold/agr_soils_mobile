import 'package:json_annotation/json_annotation.dart';

part 'weather_element.g.dart';

@JsonSerializable()
class WeatherElement {
  WeatherElement({
    required this.id,
    required this.description,
    required this.icon,
  });

  final int id;
  final String description;
  final String icon;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory WeatherElement.fromJson(Map<String, dynamic> json) => _$WeatherElementFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$WeatherElementToJson(this);
}
