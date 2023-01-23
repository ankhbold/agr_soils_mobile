class Globals {
  // static var anInteger = 0;

  static var username = '';
  static var isLogin = false;
  static var email = '';
  static var phone = '';
  static var firstname = '';
  static var lastname = '';

  // static printInteger() {
  //   print(anInteger);
  // }

  // static changeInteger(int a) {
  //   anInteger = a;
  //   printInteger(); // this can be replaced with any static method
  // }

  static changeUsername(String a) {
    username = a;
  }

  static getUsername() {
    return username;
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
