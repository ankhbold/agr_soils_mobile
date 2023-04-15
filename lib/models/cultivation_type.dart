import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'cultivation_type.g.dart';

@JsonSerializable()
class CultivationType {
  int? id;
  String? code;
  bool? is_active;
  String? name;
  String? name_en;
  String? description;
  int? order_no;
  int? parent_id;
  int? codelist_type;
  String? codelist_comment;
  String? created_at;
  String? updated_at;
  String? created_by;
  String? updated_by;
  dynamic h_formula;
  dynamic inter_no;
  dynamic start_year;
  dynamic boundary_width;
  String? boundary_color;
  String? fill_color;
  String? hover_color;
  String? image_url;
  CultivationType({
    this.id,
    this.code,
    this.is_active,
    this.name,
    this.name_en,
    this.description,
    this.order_no,
    this.parent_id,
    this.codelist_type,
    this.codelist_comment,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by,
    this.h_formula,
    this.inter_no,
    this.start_year,
    this.boundary_width,
    this.boundary_color,
    this.fill_color,
    this.hover_color,
    this.image_url,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CultivationType.fromJson(Map<String, dynamic> json) => _$CultivationTypeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CultivationTypeToJson(this);
}
