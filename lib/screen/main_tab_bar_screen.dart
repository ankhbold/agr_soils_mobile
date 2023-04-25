import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'field%20screen/field.dart';
import 'insight%20screen/insight_screen.dart';
import 'notes%20screen/notes_screen.dart';
import 'profile screen/login_with_signup_screen.dart';

var index_color = 0;

class MainTabBarPage extends StatefulWidget {
  const MainTabBarPage({Key? key}) : super(key: key);

  @override
  MainTabBarPageState createState() => MainTabBarPageState();
}

class MainTabBarPageState extends State<MainTabBarPage> with AutomaticKeepAliveClientMixin<MainTabBarPage> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  int currentIndex = 0;
  bool? isNoteSelected;
  ValueNotifier<bool> selectedNotifier = ValueNotifier(false);

  void onTabTapped(int index) {
    setState(() {
      index_color = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        FieldScreen(
          isNoteSelected: isNoteSelected,
          tabController: _controller,
        ),
        InsightScreen(
          tabController: _controller,
        ),
        NoteListPage(
          tabController: _controller,
          changeLocation: () {
            isNoteSelected = true;
            setState(() {});
          },
        ),
        LoginWithSignup()
      ],
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xff065F46), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: (currentIndex == 0 || currentIndex == 2 || currentIndex == 1) ? true : false, // Default is true.
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
      selectedTabScreenContext: (p0) {},
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      // popActionScreens: PopActionScreensType.once,
      navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/bottom_bar/areas.png"),
        title: ("Талбай"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/bottom_bar/chart.png"),
        title: ("Статистик"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/bottom_bar/notes.png"),
        title: ("Тэмдэглэл"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/bottom_bar/user.png"),
        title: ("Хэрэглэгч"),
        textStyle: TextStyle(color: Colors.grey),
        activeColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
