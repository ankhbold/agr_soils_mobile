import 'package:flutter/material.dart';
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
        SizedBox(
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
            style: TextStyle(),
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
                  style: TextStyle(),
                ),
              )
            : SizedBox(
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
                  style: TextStyle(),
                ),
              )
            : SizedBox(
                height: 1,
              ),
        Line(),
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
                    : Text('Оруулаагүй'),
              )
            : SizedBox(
                height: 1,
              ),
        Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                text: Text(
                  Globals.getUserPhone(),
                  style: TextStyle(),
                ),
              )
            : SizedBox(
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
            : SizedBox(
                height: 1,
              ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
        )
      ],
    );
  }
}
