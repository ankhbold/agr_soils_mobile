class User {
  User({
      required this.id, 
      required this.username, 
      required this.firstname, 
      required this.lastname, 
      required this.phone, 
      required this.email, 
      required this.register, 
      required this.position, 
      required this.password, 
      this.createdBy, 
      this.updatedAt, 
      this.updatedBy, 
      this.createdAt, 
      this.imageUrl, 
      this.role, 
      this.rememberToken, 
      required this.personId, 
      required this.logInProCompanyId, 
      this.passwordConfirm,});

  User.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    register = json['register'];
    position = json['position'];
    password = json['password'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    imageUrl = json['image_url'];
    role = json['role'];
    rememberToken = json['remember_token'];
    personId = json['person_id'];
    logInProCompanyId = json['log_in_pro_company_id'];
    passwordConfirm = json['password_confirm'];
  }
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? register;
  String? position;
  String? password;
  dynamic createdBy;
  dynamic updatedAt;
  dynamic updatedBy;
  dynamic createdAt;
  dynamic imageUrl;
  dynamic role;
  dynamic rememberToken;
  int? personId;
  int? logInProCompanyId;
  dynamic passwordConfirm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['phone'] = phone;
    map['email'] = email;
    map['register'] = register;
    map['position'] = position;
    map['password'] = password;
    map['created_by'] = createdBy;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['image_url'] = imageUrl;
    map['role'] = role;
    map['remember_token'] = rememberToken;
    map['person_id'] = personId;
    map['log_in_pro_company_id'] = logInProCompanyId;
    map['password_confirm'] = passwordConfirm;
    return map;
  }

}