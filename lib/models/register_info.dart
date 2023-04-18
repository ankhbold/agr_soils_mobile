class RegisterInfo {
  int? prof_company_id;
  String? person_register;
  String? firstname;
  String? lastname;
  String? phone;
  String? position_type_id;
  String? email;
  String? username;
  String? password;
  RegisterInfo({
    this.prof_company_id,
    this.person_register,
    this.firstname,
    this.lastname,
    this.phone,
    this.position_type_id,
    this.email,
    this.username,
    this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'prof_company_id': prof_company_id,
      'person_register': person_register,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'position_type_id': position_type_id,
      'email': email,
      'username': username,
      'password': password
    };
  }
}
