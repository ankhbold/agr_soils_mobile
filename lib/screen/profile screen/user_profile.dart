import 'package:flutter/material.dart';
import 'package:mvvm/services/commons/api_helper.dart';
import 'package:mvvm/themes/styles.dart';
import 'package:mvvm/widget/confirm_dialog.dart';
import 'package:mvvm/widget/loader.dart';
import 'package:mvvm/widget/snackbar.dart';
import 'package:provider/provider.dart';

import '../../conf_global.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/user_view_model.dart';
import '../../widget/line.dart';
import '../widgets/button/account_button_less.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key, this.logout});
  Function? logout;
  @override
  State<UserProfilePage> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        const Line(),
        AccountButtonLess(
          icon: const Icon(
            Icons.accessibility,
            color: Colors.black54,
          ),
          text: Text(
            '${Globals.getFirstName()} ${Globals.getLastName()}',
            style: const TextStyle(),
          ),
        ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.home_work,
                  color: Colors.black54,
                ),
                text: Text(
                  Globals.getUserCompany(),
                  style: const TextStyle(),
                ),
              )
            : const SizedBox(
                height: 1,
              ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.badge,
                  color: Colors.black54,
                ),
                text: Text(
                  Globals.getPosition(),
                  style: const TextStyle(),
                ),
              )
            : const SizedBox(
                height: 1,
              ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
                text: isEmpty
                    ? Text(
                        Globals.email,
                        style: TextStyle(),
                      )
                    : const Text('Оруулаагүй'),
              )
            : const SizedBox(
                height: 1,
              ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                text: Text(
                  Globals.getUserPhone(),
                  style: const TextStyle(),
                ),
              )
            : const SizedBox(
                height: 1,
              ),
        const Line2(),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        Globals.isLogin
            ? InkWell(
                onTap: () {
                  setState(() {
                    userPrefernece.remove().then((value) {
                      widget.logout!();
                    });
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Гарах',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            : const SizedBox(
                height: 1,
              ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              width: 20,
            ),
            Text(
              'Тариалангийн систем, 1.0.0\nios 15.5',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmDialog(
                  isAlert: true,
                  text:
                      'Та өөрийн хэрэглэгчийн бүртгэл устгаснаар таны мэдээллүүд бүрэн устах бөгөөд дахин сэргээгдэх боломжгүйг анхаарна уу.',
                );
              },
            ).then((value) {
              if (value != null && value) {
                LoadingIndicator(context: context).showLoadingIndicator();
                ApiHelper().getUrl(url: '/api/user/delete?user_id=${Globals.user_id}').then((value) {
                  LoadingIndicator(context: context).hideLoadingIndicator();
                  setState(() {
                    userPrefernece.remove().then((value) {
                      widget.logout!();
                    });
                  });
                }).catchError((onError) {
                  print(onError);
                  LoadingIndicator(context: context).hideLoadingIndicator();
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                    message: onError.toString(),
                  ));
                });
              }
            });
          },
          child: const Text(
            'Хэрэглэгчийн бүртгэл устгах',
            style: TextStyle(color: primaryColor, fontSize: 15),
          ),
        )
      ],
    );
  }
}
