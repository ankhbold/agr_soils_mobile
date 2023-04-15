class CreateUnitAreaModelRequest {
  String? description;
  String? field_name;
  int? cult_type;
  List<List<double>>? geom;
  CreateUnitAreaModelRequest({this.description, this.field_name, this.cult_type, this.geom});
  toJson() {
    return {
      'description': description,
      'field_name': field_name,
      'cult_type': cult_type,
      'geom': geom,
    };
  }
}
