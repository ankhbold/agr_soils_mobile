import 'package:json_annotation/json_annotation.dart';

part 'sensor_info.g.dart';

@JsonSerializable()
class SensorInfo {
  int? sensor_id;
  String? sensor_serial;
  String? s_version;
  String? last_connection;
  String? device_version;
  String? installed_at;
  int? coordinate_id;
  String? x_coordinate;
  String? y_coordinate;
  SensorInfo({
    this.sensor_id,
    this.sensor_serial,
    this.s_version,
    this.last_connection,
    this.device_version,
    this.installed_at,
    this.coordinate_id,
    this.x_coordinate,
    this.y_coordinate,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SensorInfo.fromJson(Map<String, dynamic> json) => _$SensorInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SensorInfoToJson(this);
}
