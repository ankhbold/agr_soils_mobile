class GeoJsons {
  GeoJsons({
    required this.status,
    required this.returnGeoJson,
  });

  GeoJsons.fromJson(dynamic json) {
    status = json['status'];
    returnGeoJson = json['returnGeoJson'];
  }
  bool? status;
  String? returnGeoJson;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['returnGeoJson'] = returnGeoJson;
    return map;
  }
}
