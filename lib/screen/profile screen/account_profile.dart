import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../conf_global.dart';
import '../../constants/color.dart';
import '../../view_model/user_view_model.dart';
import '../../widget/line.dart';
import '../login_view.dart';
import '../widgets/button/account_button.dart';


class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
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
              children: const [
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
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        title: const Text(
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
              'batitgel@gmail.com',
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
              Icons.phone,
              color: Colors.black54,
            ),
            text: const Text(
              '94091515',
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
              Icons.build,
              color: Colors.black54,
            ),
            text: const Text(
              'company',
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
              'Нууц үг                ',
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
              'Хэрэглэгчийг устгах',
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
              setState(() {
                userPrefernece.remove().then((value) {
                  Globals.changeIsLogin(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                });
              });
            },
            child: Ink(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  'Гарах',
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
