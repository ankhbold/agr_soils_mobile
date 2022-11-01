import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/res/components/account_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:mvvm/widget/floating_widget.dart';
import 'package:provider/provider.dart';

import '../res/components/season_sheet_button.dart';
import '../screen/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: ProfileAppBar(context),
      body: ListView(
        children: [
          Line3(),
          UnitSystem(),
          Line2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Switch.adaptive(
                  activeColor: AppColors.Green,
                  value: false,
                  onChanged: (newValue) => (() => _value = newValue)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Line2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          OfflineMaps(context),
          Line2(),
          SettingsButton(),
          Line(),
          SettingsButton(),
          Line()
        ],
      ),
    );
  }

  AppBar ProfileAppBar(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      title: Text(
        'Тохиргоо',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  SizedBox OfflineMaps(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                'Offline maps',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Maps around my fields',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              InkWell(
                child: Ink(
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_download,
                        color: AppColors.Green,
                      ),
                      Text(
                        'download',
                        style: TextStyle(
                            color: AppColors.Green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.black.withOpacity(0.1),

      // splashColor: Colors.black,
      onTap: () {},
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.black54,
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

class UnitSystem extends StatelessWidget {
  const UnitSystem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                'Unit system',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.check,
                color: AppColors.Green,
                size: 25,
              ),
              Text(
                'Metric: kg, ha, m/s, mm, C*',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
              ),
              Text(
                'Imperial: kg, ha, m/s, mm, C*',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
              ),
              Text(
                'Canada: kg, ha, m/s, mm, C*',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
