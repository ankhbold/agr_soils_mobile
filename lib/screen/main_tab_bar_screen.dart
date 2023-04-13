import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../view_model/home_view_model.dart';
import 'field%20screen/field.dart';
import 'insight%20screen/insight_screen.dart';
import 'notes%20screen/notes_screen.dart';
import 'profile screen/login_with_signup_screen.dart';

var index_color = 0;
HomeViewViewModel homeViewViewModel = HomeViewViewModel();

class MainTabBarPage extends StatefulWidget {
  const MainTabBarPage({Key? key}) : super(key: key);

  @override
  MainTabBarPageState createState() => MainTabBarPageState();
}

class MainTabBarPageState extends State<MainTabBarPage> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> screens = [];
  int currentIndex = 0;

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
    screens = [
      FieldScreen(
        tabController: _controller,
      ),
      InsightScreen(
        tabController: _controller,
      ),
      NoteListPage(
        tabController: _controller,
        changeLocation: () {
          print('duudsam');
        },
      ),
      LoginWithSignup()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xff065F46), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      onItemSelected: (value) {
        currentIndex = value;
        setState(() {});
      },
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.nfc,
        ),
        title: ("Талбай"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.leaderboard),
        title: ("Статистик"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.speaker_notes),
        title: ("Тэмдэглэл"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_box_rounded),
        title: ("Хэрэглэгч"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
    ];
  }
}
