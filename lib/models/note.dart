import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'note.g.dart';

@JsonSerializable()
class Note {
  int? id;
  int? parcel_id;
  int? crops_area_id;
  String? note_date;
  String? description;
  String? geometry;
  String? x_coordinate;
  String? y_coordinate;
  String? created_at;
  String? updated_at;
  String? created_by;
  String? updated_by;
  int? note_type;
  int? season_id;
  String? sent_date;
  String? end_date;
  String? note_type_desc;
  String? image_url;
  List<String>? images;
  Note({
    this.id,
    this.parcel_id,
    this.crops_area_id,
    this.note_date,
    this.description,
    this.geometry,
    this.x_coordinate,
    this.y_coordinate,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by,
    this.sent_date,
    this.end_date,
    this.note_type_desc,
    this.image_url,
    this.images,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
