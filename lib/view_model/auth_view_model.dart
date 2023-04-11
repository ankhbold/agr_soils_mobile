import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../conf_global.dart';
import '../models/user_model.dart';
import '../respository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

bool isEmpty = false;
bool wrong = false;

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
      if (value['status']) {
        print(value['data']['firstname']);
        var in_email = '';
        var in_username = '';
        var in_position = '';
        var in_company = '';
        var in_personId = '';
        var in_firstname = '';
        var in_lastname = '';
        var in_phone = '';
        if (value['data']['email'] != null) {
          isEmpty = true;
          in_email = value['data']['email'];
        }

        if (value['data']['username'] != null) {
          in_username = value['data']['username'];
        }

        if (value['data']['position_name'] != null) {
          in_position = value['data']['position_name'];
        }
        if (value['data']['prof_company_name'] != null) {
          in_company = value['data']['prof_company_name'];
        }
        if (value['data']['company_id'] != null) {
          in_personId = value['data']['company_id'].toString();
        }

        if (value['data']['firstname'] != null) {
          in_firstname = value['data']['firstname'];
        }
        if (value['data']['lastname'] != null) {
          in_lastname = value['data']['lastname'];
        }
        if (value['data']['phone'] != null) {
          in_phone = value['data']['phone'];
        }
        Globals.changeUsername(in_username);
        Globals.changePCI(value['data']['prof_company_id'].toString());
        Globals.changeUserEmail(in_email);
        Globals.changeUserPhone(in_phone.toString());
        Globals.changeUserCompany(in_company.toString());

        Globals.changeFirstName(in_firstname);
        Globals.changeLastName(in_lastname);
        Globals.changePosition(in_position);
        setLoading(false);
        Globals.changePersonId(in_personId);

        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference
            .saveUser(UserModel(user_id: value['data']['user_id'].toString()));

        Utils.flushBarErrorMessage('Амжилттай нэвтэрлээ', context);

        Globals.changeIsLogin(true);

        Future<UserModel> getUserDate() => UserViewModel().getUser();
        getUserDate().then((value) {
          // print(value.user_id.toString());
        });

        // Navigator.pushNamed(context, RoutesName.home);
        // if (kDebugMode) {
          // print(value.toString());
        // }
      } else {
        Utils.flushBarErrorMessage(
            'Хэрэглэгчийн нэр эсвэл нууц үг буруу байна!!!', context);
        wrong = true;
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
      Utils.flushBarErrorMessage('Амжилттай бүргүүллээ', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        // print(value.toString());
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
