import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/field.dart';
import 'package:mvvm/screen/notes_screen.dart';
import 'package:mvvm/screen/profile_screen.dart';
import 'package:mvvm/screen/test_screen.dart';

import 'package:mvvm/view_model/home_view_model.dart';

import '../widget/note_add_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  int index_color = 0;
  List Screen = [
    const FieldScreen(),
    const TestScreen(),
    const ScreenTwo(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    // final userPrefernece = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: Screen[index_color],
      bottomNavigationBar: homeBottomBar(context),
    );
  }

  Container homeBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: const Color.fromARGB(255, 251, 250, 250),
      ),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Column(
                  children: [
                    Icon(
                      Icons.nfc,
                      color: index_color == 0
                          ? const Color(0xff368983)
                          : Colors.grey,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.006,
                    ),
                    // Text(
                    //   'Талбайd',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: index_color == 0
                    //         ? Color(0xff368983)
                    //         : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
              ),
              GestureDetector(
                child: Column(
                  children: [
                    Icon(
                      Icons.speaker_notes,
                      color: index_color == 1
                          ? const Color(0xff368983)
                          : Colors.grey,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.006,
                    ),
                    // Text(
                    //   'Тэмдэглэл',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: index_color == 1
                    //         ? Color(0xff368983)
                    //         : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
              ),
              Column(
                children: const [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width * 0.015,
                  // ),
                  CustomAddButton(),
                ],
              ),
              GestureDetector(
                child: Column(
                  children: [
                    Icon(
                      Icons.leaderboard,
                      color: index_color == 2
                          ? const Color(0xff368983)
                          : Colors.grey,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.006,
                    ),
                    // Text(
                    //   'Статистик',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: index_color == 2
                    //         ? Color(0xff368983)
                    //         : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                onTap: () {
                  setState(
                    () {
                      index_color = 2;
                    },
                  );
                },
              ),
              GestureDetector(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      color: index_color == 3
                          ? const Color(0xff368983)
                          : Colors.grey,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.006,
                    ),
                    // Text(
                    //   'Аккоунт',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //     color: index_color == 3
                    //         ? Color(0xff368983)
                    //         : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                onTap: () {
                  setState(
                    () {
                      index_color = 3;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
