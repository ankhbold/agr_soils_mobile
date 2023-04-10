import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../conf_global.dart';
import '../constants/colors.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';
import 'widgets/button/round_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    _emailController.text = 'ankhbold';
    _passwordController.text = '89006176';

    // final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                )),
            Center(
              child: Text(
                // textAlign: TextAlign.center,
                'УХААЛАГ ГАЗАР ТАРИАЛАН',
                textAlign: TextAlign.center,

                style: GoogleFonts.montserrat(
                  color: AppColors.green,
                  textStyle: TextStyle(fontSize: 18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Нэвтрэх нэр оруулна уу',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                right: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return TextField(
                        controller: _passwordController,
                        obscureText: _obsecurePassword.value,
                        focusNode: passwordFocusNode,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Нууц үг оруулна уу',
                          // labelText: 'Нууц үг',
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Нууц үг мартсан?',
                      style: GoogleFonts.montserrat(
                        letterSpacing: 0.05,
                        textStyle: TextStyle(

                            // color: Color.fromARGB(150, 0, 0, 0),
                            color: AppColors.Green,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            RoundButton(
              title: 'Нэвтрэх',
              loading: authViewMode.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      'Нэвтрэх нэрээ оруулна уу', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Нууц үг оруулна уу', context);
                } else if (_passwordController.text.length < 3) {
                  Utils.flushBarErrorMessage(
                      '6 оронтой тоо оруулна уу', context);
                } else {
                  Map data = {
                    'username': _emailController.text.toString(),
                    'password': _passwordController.text.toString(),
                  };
                  authViewMode.loginApi(data, context);
                  print('api hit');
                  print(Globals.getPCI());
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
