// class UserModel {
//   String? user_id;

//   UserModel({this.user_id});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     user_id = json['user_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.user_id;

//     return data;
//   }
// }
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

// class Data {
//   int? id;
//   String? username;
//   String? firstname;
//   String? lastname;
//   String? phone;
//   Null? email;
//   String? register;
//   int? createdBy;
//   String? updatedAt;
//   Null? updatedBy;
//   String? createdAt;
//   Null? imageUrl;
//   String? role;
//   int? personId;
//   int? logInProCompanyId;
//   String? passwordConfirm;
//   int? position;

//   Data(
//       {this.id,
//       this.username,
//       this.firstname,
//       this.lastname,
//       this.phone,
//       this.email,
//       this.register,
//       this.createdBy,
//       this.updatedAt,
//       this.updatedBy,
//       this.createdAt,
//       this.imageUrl,
//       this.role,
//       this.personId,
//       this.logInProCompanyId,
//       this.passwordConfirm,
//       this.position});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     phone = json['phone'];
//     email = json['email'];
//     register = json['register'];
//     createdBy = json['created_by'];
//     updatedAt = json['updated_at'];
//     updatedBy = json['updated_by'];
//     createdAt = json['created_at'];
//     imageUrl = json['image_url'];
//     role = json['role'];
//     personId = json['person_id'];
//     logInProCompanyId = json['log_in_pro_company_id'];
//     passwordConfirm = json['password_confirm'];
//     position = json['position'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['firstname'] = this.firstname;
//     data['lastname'] = this.lastname;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['register'] = this.register;
//     data['created_by'] = this.createdBy;
//     data['updated_at'] = this.updatedAt;
//     data['updated_by'] = this.updatedBy;
//     data['created_at'] = this.createdAt;
//     data['image_url'] = this.imageUrl;
//     data['role'] = this.role;
//     data['person_id'] = this.personId;
//     data['log_in_pro_company_id'] = this.logInProCompanyId;
//     data['password_confirm'] = this.passwordConfirm;
//     data['position'] = this.position;
//     return data;
//   }
// }
