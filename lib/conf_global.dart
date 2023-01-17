class Globals {
  static var anInteger = 0;

  static var username = '';
  static var isLogin = false;

  static printInteger() {
    print(anInteger);
  }

  static changeInteger(int a) {
    anInteger = a;
    printInteger(); // this can be replaced with any static method
  }

  static changeUsername(String a) {
    username = a;
  }

  static getUsername() {
    return username;
  }

  static changeIsLogin(bool a) {
    isLogin = a;
  }

  static getIsLogin() {
    return isLogin;
  }
}
