import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/respository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      print('*****');
      print(value);
      print('*****');
      setLoading(false);
      if (value['status']) {
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference
            .saveUser(UserModel(user_id: value['data']['id'].toString()));

        Utils.flushBarErrorMessage('Login Successfully', context);

        ////
        print('------');
        Future<UserModel> getUserDate() => UserViewModel().getUser();
        getUserDate().then((value) {
          print(value.user_id.toString());
        });
        ////

        Navigator.pushNamed(context, RoutesName.home);
        if (kDebugMode) {
          print(value.toString());
        }
      } else {
        Utils.flushBarErrorMessage(
            'Хэрэглэгчийн нэр эсвэл нууц үг буруу байна!!!', context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
