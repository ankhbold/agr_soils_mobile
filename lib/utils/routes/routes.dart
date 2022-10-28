import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/screen/home_screen.dart';
import 'package:mvvm/screen/login_view.dart';
import 'package:mvvm/screen/signp_view.dart';
import 'package:mvvm/ui/splash/intro_screen.dart';
import 'package:mvvm/ui/splash/splash_view.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.intro:
        return MaterialPageRoute(
            builder: (BuildContext context) => const IntroScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());

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
