// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: json['id'] as int?,
      parcel_id: json['parcel_id'] as int?,
      crops_area_id: json['crops_area_id'] as int?,
      note_date: json['note_date'] as String?,
      description: json['description'] as String?,
      geometry: json['geometry'] as String?,
      x_coordinate: json['x_coordinate'] as String?,
      y_coordinate: json['y_coordinate'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      created_by: json['created_by'] as String?,
      updated_by: json['updated_by'] as String?,
      sent_date: json['sent_date'] as String?,
      end_date: json['end_date'] as String?,
      note_type_desc: json['note_type_desc'] as String?,
      image_url: json['image_url'] as String?,
    )
      ..note_type = json['note_type'] as int?
      ..season_id = json['season_id'] as int?;

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'parcel_id': instance.parcel_id,
      'crops_area_id': instance.crops_area_id,
      'note_date': instance.note_date,
      'description': instance.description,
      'geometry': instance.geometry,
      'x_coordinate': instance.x_coordinate,
      'y_coordinate': instance.y_coordinate,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_by': instance.created_by,
      'updated_by': instance.updated_by,
      'note_type': instance.note_type,
      'season_id': instance.season_id,
      'sent_date': instance.sent_date,
      'end_date': instance.end_date,
      'note_type_desc': instance.note_type_desc,
      'image_url': instance.image_url,
    };
