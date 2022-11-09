import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../screen/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: ProfileAppBar(context),
      body: ListView(
        children: [
          const Line3(),
          const UnitSystem(),
          const Line2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              const Text(
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
          const Line2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          OfflineMaps(context),
          const Line2(),
          const SettingsButton(),
          const Line(),
          const SettingsButton(),
          const Line()
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
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      title: const Text(
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
              const Text(
                'Оффлайн газрын зураг',
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
              const Text(
                'Манай талбайн ойролцоох газрын зураг',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.01,
                  ),
              InkWell(
                child: Ink(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.file_download,
                        color: AppColors.Green,
                      ),
                      Text(
                        'татах',
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
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Text(
                'Нууцлал',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
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
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              const Text(
                'Системийн нэгж',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
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
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 80,
              ),
              Text(
                'Imperial: kg, ha, m/s, mm, C*',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 80,
              ),
              Text(
                'Canada: kg, ha, m/s, mm, C*',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
