import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants/colors.dart';
import '../view_model/home_view_model.dart';
import 'field%20screen/field.dart';
import 'insight%20screen/insight_screen.dart';
import 'notes%20screen/notes_screen.dart';
import 'profile screen/login_with_signup_screen.dart';

var index_color = 0;
HomeViewViewModel homeViewViewModel = HomeViewViewModel();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Screen = [
    FieldScreen(),
    InsightScreen(),
    NoteListPage(),
    LoginWithSignup(),
  ];
  void onTabTapped(int index) {
    setState(() {
      index_color = index;
      // Globals.changeIndexColor(index);
      // print(Globals.getIndexColor());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final authViewMode = Provider.of<AuthViewModel>(context, listen: false);
    //   Map data = {
    //     'username': "ankhbold",
    //     'password': "89006176",
    //   };
    //   authViewMode.loginApi(data, context);
    // });
    return Scaffold(
      body: Screen[index_color],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: AppColors.grad,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, top: 5),
          child: GNav(
            tabBackgroundColor: Color.fromARGB(47, 255, 255, 255),
            color: Color.fromARGB(255, 255, 255, 255),
            activeColor: Colors.white,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            tabBorderRadius: 30,
            onTabChange: onTabTapped,
            tabs: [
              GButton(
                icon: Icons.nfc,
                text: ' Талбай',
              ),
              GButton(
                icon: Icons.leaderboard,
                text: ' Статистик',
              ),
              GButton(
                icon: Icons.speaker_notes,
                text: ' Тэмдэглэл',
              ),
              GButton(
                icon: Icons.account_box_rounded,
                text: ' Хэрэглэгч',
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: index_color,
      //   // showUnselectedLabels: false,
      //   iconSize: 25,
      //   selectedItemColor: AppColors.Green,
      //   onTap: (index) => setState(
      //     () => index_color = index,
      //   ),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.nfc,
      //         // color: Colors.black,
      //       ),
      //       label: 'Талбар',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.leaderboard,
      //         // color: Colors.black,
      //       ),
      //       label: 'Статистик',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.speaker_notes,
      //         // color: Colors.black,
      //       ),
      //       label: 'Тэмдэглэл',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.account_box_rounded,
      //         // color: Colors.black,
      //       ),
      //       label: 'Хэрэглэгч',
      //     ),
      //   ],
      // ),
    );
  }
}
