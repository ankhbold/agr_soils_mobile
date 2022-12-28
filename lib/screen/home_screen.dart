import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/field%20screen/field.dart';
import 'package:mvvm/screen/insight%20screen/insight_screen.dart';
import 'package:mvvm/screen/notes%20screen/notes_screen.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:mvvm/view_model/home_view_model.dart';

HomeViewViewModel homeViewViewModel = HomeViewViewModel();
int index_color = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Screen = [
    FieldScreen(),
    InsightScreen(),
    ScreenTwo(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      bottomNavigationBar: Container(
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
                        Icons.leaderboard,
                        color: index_color == 1
                            ? const Color(0xff368983)
                            : Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      index_color = 1;
                    });
                  },
                ),
                Column(
                  children: [
                    FloatingActionButton.small(
                      backgroundColor: AppColors.Green,
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      elevation: 0,
                      onPressed: () {
                        setState(
                          () {
                            index_color = 0;
                            isFabVisible = false;
                            // note = !note;
                            isFirstWidgetVisible = false;
                            isAddFieldWidgetVisible = false;
                            isSecondWidgetVisible = true;
                            isThirdWidgetVisible = false;
                          },
                        );
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.speaker_notes,
                        color: index_color == 2
                            ? const Color(0xff368983)
                            : Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.006,
                      ),
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
      ),
    );
  }
}
