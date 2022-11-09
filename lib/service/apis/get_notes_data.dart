// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.code,
    required this.isActive,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.orderNo,
    required this.parentId,
    required this.codelistType,
    required this.codelistComment,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  int id;
  String code;
  bool isActive;
  String name;
  String nameEn;
  String description;
  int orderNo;
  int parentId;
  int codelistType;
  String codelistComment;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        code: json["code"],
        isActive: json["is_active"],
        name: json["name"],
        nameEn: json["name_en"],
        description: json["description"],
        orderNo: json["order_no"],
        parentId: json["parent_id"],
        codelistType: json["codelist_type"],
        codelistComment: json["codelist_comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "is_active": isActive,
        "name": name,
        "name_en": nameEn,
        "description": description,
        "order_no": orderNo,
        "parent_id": parentId,
        "codelist_type": codelistType,
        "codelist_comment": codelistComment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
