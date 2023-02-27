import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/service_satelete.dart';
import 'package:mvvm/screen/home_screen.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await fetchSate();
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return Material(
  //     child: Container(
  //       color: Colors.green,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: const [
  //           Text(
  //             'Зүгээрдэээ Итгэлэээ',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 25,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // };

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
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
        // initialRoute: RoutesName.splash,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
