class GetSeason {
  GetSeason({
    required this.id,
    required this.seasonName,
    required this.isActive,
    this.description,
    required this.proPersonId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.updatedBy,
  });

  GetSeason.fromJson(dynamic json) {
    id = json['id'];
    seasonName = json['season_name'];
    isActive = json['is_active'];
    description = json['description'];
    proPersonId = json['pro_person_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  String? id;
  String? seasonName;
  bool? isActive;
  dynamic description;
  int? proPersonId;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  dynamic updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['season_name'] = seasonName;
    map['is_active'] = isActive;
    map['description'] = description;
    map['pro_person_id'] = proPersonId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }
}
