import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/field.dart';
import 'package:mvvm/screen/insight_screen.dart';
import 'package:mvvm/screen/notes_screen.dart';
import 'package:mvvm/screen/profile_screen.dart';
import 'package:mvvm/view_model/home_view_model.dart';

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
    const NoteScreen(),
    const ScreenTwo(),
    const ProfilePage(),
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
                        Icons.speaker_notes,
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
                          setState(() {
                            fabshow = false;
                            note = !note;
                          });
                        }),
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

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          buildNavigator(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        note = !note;
                      });
                    },
                    child: Text(
                      'Буцах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Тэмдэглэл',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Хадгалах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Line4(),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              // color: Colors.amber[500],
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Таны тэмдэглэл...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Line4(),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: InkWell(
              onTap: () {},
              child: Ink(
                height: MediaQuery.of(context).size.width * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.Green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Зураг оруулах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Line5()
        ],
      ),
    );
  }
}

Widget buildNavigator() => Container(
      padding: EdgeInsets.only(right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

class Line4 extends StatelessWidget {
  const Line4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black,
          height: 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }
}

class Line5 extends StatelessWidget {
  const Line5({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black,
          height: 0.2,
          width: MediaQuery.of(context).size.width * 0.95,
        ),
      ],
    );
  }
}
