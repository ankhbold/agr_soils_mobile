class CreateSeasonModelRequest {
  int? season_id;
  String? name;
  String? start;
  String? end;
  CreateSeasonModelRequest({
    this.season_id,
    this.name,
    this.start,
    this.end,
  });
  Map<String, dynamic> toJson() {
    return {
      'season_id': season_id,
      'name': name,
      'start': start,
      'end': end,
    };
  }
}
