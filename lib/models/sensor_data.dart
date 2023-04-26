import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

@JsonSerializable()
class SensorData {
  String? unix_datetime;
  int? id;
  String? air_moisture;
  String? air_moisture_secondary;
  String? air_temp;
  String? air_temp_secondary;
  String? battery;
  String? coordinate_id;
  String? datetime;
  String? dew_point;
  String? luminance;
  String? moisture;
  String? moisture_secondary;
  String? raw_air_pressure;
  String? raw_air_pressure_secondary;
  String? raw_moisture;
  String? raw_moisture_secondary;
  String? temp;
  String? temp_secondary;
  String? created_at;
  String? updated_at;
  String? created_by;
  String? updated_by;
  SensorData({
    this.unix_datetime,
    this.id,
    this.air_moisture,
    this.air_moisture_secondary,
    this.air_temp,
    this.air_temp_secondary,
    this.coordinate_id,
    this.battery,
    this.datetime,
    this.dew_point,
    this.luminance,
    this.moisture,
    this.moisture_secondary,
    this.raw_air_pressure,
    this.raw_air_pressure_secondary,
    this.raw_moisture,
    this.raw_moisture_secondary,
    this.temp,
    this.temp_secondary,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SensorData.fromJson(Map<String, dynamic> json) => _$SensorDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SensorDataToJson(this);
}
