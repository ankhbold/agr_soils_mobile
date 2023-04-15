import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/main_tab_bar_screen.dart';
import 'themes/styles.dart';
import 'utils/routes/routes.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/user_view_model.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel())
      ],
      child: MaterialApp(
        onGenerateRoute: Routes.generateRoute,
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: MainTabBarPage(),
      ),
    );
  }
}
