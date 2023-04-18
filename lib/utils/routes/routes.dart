import 'package:flutter/material.dart';

import '../../screen/login_view.dart';
import '../../screen/main_tab_bar_screen.dart';
import '../../screen/notes%20screen/notes_screen.dart';

import '../../ui/splash/intro_screen.dart';
import '../../ui/splash/splash_view.dart';
import 'routes_name.dart';
import '../../screen/signup_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.intro:
        return MaterialPageRoute(builder: (BuildContext context) => const IntroScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const MainTabBarPage());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
      case RoutesName.note:
        return MaterialPageRoute(builder: (BuildContext context) => NoteListPage());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
