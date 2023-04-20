import 'models/note.dart';

class Globals {
  // static var anInteger = 0;

  static var username = 'ankhbold';
  static var isLogin = true;
  static var seasonId;
  static var email = '';
  static var phone = '89006176';
  static var firstname = 'Анхболд';
  static var lastname = 'Баатарболд';
  static var position = '';
  static var company = 'Aгрономич';
  static var index_color = 0;
  static var personId = '626247';
  static var prof_company_id = '1';
  static var company_id = '';
  static var latit = '';
  static var longit = '';
  static Note? selectedNote;

  // static printInteger() {
  //   print(anInteger);
  // }

  static changeSelectedNote(Note? a) {
    selectedNote = a;
  }

  static changeIndexColor(int a) {
    index_color = a;
  }

  static getIndexColor() {
    return index_color;
  }

  static changePersonId(String a) {
    personId = a;
  }

  static getPersonId() {
    return personId;
  }

  static changeLatitude(double a) {
    latit = a.toString();
  }

  static changeLongtitude(double a) {
    longit = a.toString();
  }

  static getLatitude() {
    return latit;
  }

  static changePCI(String a) {
    prof_company_id = a;
  }

  static getPCI() {
    return prof_company_id;
  }

  static changeUsername(String a) {
    username = a;
  }

  static getUsername() {
    return username;
  }

  static changePosition(String a) {
    position = a;
  }

  static getPosition() {
    return position;
  }

  static changeUserEmail(String a) {
    email = a;
  }

  static getUserEmail() {
    return email;
  }

  static changeUserPhone(String a) {
    phone = a;
  }

  static getUserPhone() {
    return phone;
  }

  static changeUserCompany(String a) {
    company = a;
  }

  static changeCompanyId(String a) {
    company_id = a;
  }

  static getUserCompany() {
    return company;
  }

  static changeFirstName(String a) {
    firstname = a;
  }

  static getFirstName() {
    return firstname;
  }

  static changeLastName(String a) {
    lastname = a;
  }

  static getLastName() {
    return lastname;
  }

  static changeIsLogin(bool a) {
    isLogin = a;
  }

  static getIsLogin() {
    return isLogin;
  }
}
