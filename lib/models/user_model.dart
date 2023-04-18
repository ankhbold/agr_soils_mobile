class UserModel {
  String? user_id;
  UserModel({this.user_id});

  UserModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.user_id != null) {
      data['user_id'] = this.user_id!;
    }
    return data;
  }
}
