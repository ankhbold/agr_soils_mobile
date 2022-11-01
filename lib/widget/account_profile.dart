import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/res/components/account_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:mvvm/widget/floating_widget.dart';
import 'package:provider/provider.dart';

import '../screen/profile_screen.dart';

class AccountProfile extends StatelessWidget {
  AccountProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Ink(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.Green,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(color: AppColors.Green, fontSize: 17),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        title: Text(
          'Миний бүртгэл',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          const Line3(),
          AccountButton(
            icon: const Icon(
              Icons.mail,
              color: Colors.black54,
            ),
            text: const Text(
              'change mail',
              style: TextStyle(),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AccountProfile()),
              // );
            },
          ),
          const Line(),
          AccountButton(
            icon: const Icon(
              Icons.lock,
              color: Colors.black54,
            ),
            text: const Text(
              'change password                 ',
              style: TextStyle(),
            ),
            onTap: () {},
          ),
          const Line(),
          AccountButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black54,
            ),
            text: const Text(
              'delete account         ',
              style: TextStyle(),
            ),
            onTap: () {},
          ),
          const Line2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          InkWell(
            onTap: () {
              userPrefernece.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Ink(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'sign out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
