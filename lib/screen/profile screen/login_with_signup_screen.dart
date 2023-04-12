import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../conf_global.dart';
import '../../view_model/user_view_model.dart';
import '../login_view.dart';
import '../profile%20screen/user_profile.dart';
import '../register/register_page.dart';

class LoginWithSignup extends StatefulWidget {
  const LoginWithSignup({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWithSignup> createState() => LoginWithSignupState();
}

class LoginWithSignupState extends State<LoginWithSignup> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: Consumer(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Globals.isLogin
                  ? UserProfilePage(
                      logout: () {
                        Globals.changeIsLogin(false);
                        setState(() {});
                      },
                    )
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration:
                                BoxDecoration(color: Color(0xff065F46), borderRadius: BorderRadius.circular(10)),
                            child: TabBar(
                                unselectedLabelColor: Colors.white,
                                labelColor: Color(0xff065F46),
                                indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                indicatorPadding: EdgeInsets.all(5),
                                overlayColor: MaterialStateProperty.all(Colors.green),
                                onTap: (value) {
                                  currentIndex = value;
                                  setState(() {});
                                },
                                tabs: [
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Нэвтрэх'),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Бүртгүүлэх'),
                                    ),
                                  ),
                                ]),
                          ),
                          currentIndex == 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height - 190,
                                  child: LoginView(),
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.height - 190,
                                  child: RegisterPage(),
                                ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
