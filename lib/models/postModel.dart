// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({required this.type, required this.id, required this.properties});

  String type;
  String id;
  Properties properties;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      type: json["type"],
      id: json["id"],
      properties: Properties.fromJson(json["properties"]));

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "properties": properties.toJson(),
      };
}

class Properties {
  Properties({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
