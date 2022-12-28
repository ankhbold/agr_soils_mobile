class GetNote {
  GetNote({
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
    this.hFormula,
    this.interNo,
    this.startYear,
  });

  GetNote.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    isActive = json['is_active'];
    name = json['name'];
    nameEn = json['name_en'];
    description = json['description'];
    orderNo = json['order_no'];
    parentId = json['parent_id'];
    codelistType = json['codelist_type'];
    codelistComment = json['codelist_comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    hFormula = json['h_formula'];
    interNo = json['inter_no'];
    startYear = json['start_year'];
  }
  int? id;
  String? code;
  bool? isActive;
  String? name;
  String? nameEn;
  String? description;
  int? orderNo;
  int? parentId;
  int? codelistType;
  String? codelistComment;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic hFormula;
  dynamic interNo;
  dynamic startYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['is_active'] = isActive;
    map['name'] = name;
    map['name_en'] = nameEn;
    map['description'] = description;
    map['order_no'] = orderNo;
    map['parent_id'] = parentId;
    map['codelist_type'] = codelistType;
    map['codelist_comment'] = codelistComment;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['h_formula'] = hFormula;
    map['inter_no'] = interNo;
    map['start_year'] = startYear;
    return map;
  }
}
