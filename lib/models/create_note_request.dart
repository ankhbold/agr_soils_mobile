class CreateNoteRequestModel {
  int? season_id;
  String? description;
  int? note_type;
  String? cordinate_x;
  String? cordinate_y;
  String? send_date;
  List<String>? files;
  CreateNoteRequestModel({
    this.season_id,
    this.description,
    this.note_type,
    this.cordinate_x,
    this.cordinate_y,
    this.send_date,
    this.files,
  });
  Map<String, dynamic> toJson() {
    return {
      'season_id': season_id,
      'description': description,
      'note_type': note_type,
      'cordinate_x': cordinate_x,
      'cordinate_y': cordinate_y,
      'send_date': send_date,
      'files': files,
    };
  }
}
