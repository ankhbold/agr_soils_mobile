import 'package:flutter/material.dart';

class Properties {
  Properties({
    // required this.id,
    required this.name,
    required this.color,
  });

  Properties.fromJson(Map json) {
    // id = json['id'];
    name = json['name'];
  }
  // String? id;
  late final String name;
  Color? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Model {
  const Model(this.name, this.color);

  final String name;

  final Color color;
}
