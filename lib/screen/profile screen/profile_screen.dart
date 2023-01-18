import 'package:flutter/material.dart';
import 'package:mvvm/screen/login_view.dart';
import 'package:mvvm/screen/profile%20screen/account_profile.dart';
import 'package:mvvm/conf_global.dart';
import 'package:mvvm/screen/widgets/button/account_button.dart';
import 'package:mvvm/screen/widgets/button/account_button_less.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final controller = PageController(
    //   initialPage: 0,
    // );
    // final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Navigator(
        onGenerateRoute: (settings) {
          Widget page = const ListProfile();
          if (settings.name == 'page2') page = const AccountProfile();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}

class ListProfile extends StatefulWidget {
  const ListProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);

    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black54,
                ),
                text: Text(
                  '${Globals.getUsername()} (${Globals.email})',
                  style: TextStyle(),
                ),
              )
            : AccountButton(
                icon: Icon(
                  Icons.account_box_rounded,
                  color: Colors.white,
                ),
                text: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                }),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.accessibility,
                  color: Colors.black54,
                ),
                text: Text(
                  '${Globals.getFirstName()} ${Globals.getLastName()}',
                  style: TextStyle(),
                ),
              )
            : SizedBox(
                height: 1,
              ),
        const Line(),
        Globals.isLogin
            ? AccountButtonLess(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                text: Text(
                  Globals.getUserPhone(),
                  style: TextStyle(),
                ),
              )
            : SizedBox(
                height: 1,
              ),
        const Line2(),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        Globals.isLogin
            ? InkWell(
                onTap: () {
                  setState(() {
                    userPrefernece.remove().then((value) {
                      Globals.changeIsLogin(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    });
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Гарах',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 1,
              ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Тариалангийн систем, 1.0.0\nios 15.5',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Colors.black,
          height: 0.07,
          width: MediaQuery.of(context).size.width * 0.85,
        ),
      ],
    );
  }
}

class Line2 extends StatelessWidget {
  const Line2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Colors.black,
          height: 0.1,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}

class Line3 extends StatelessWidget {
  const Line3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Colors.black,
          height: 0.2,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}

class Line4 extends StatelessWidget {
  const Line4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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

// class ProfilePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ProfilePageState();
//   }
// }

// class _ProfilePageState extends State<ProfilePage> {
//   double _drawerIconSize = 24;
//   double _drawerFontSize = 17;

//   @override
//   Widget build(BuildContext context) {
//     final userPrefernece = Provider.of<UserViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Миний бүртгэл",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0.5,
//         iconTheme: IconThemeData(color: Colors.white),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: <Color>[
//                 Theme.of(context).primaryColor,
//               ])),
//         ),
//         actions: [
//           Container(
//             margin: EdgeInsets.only(
//               top: 16,
//               right: 16,
//             ),
//             child: Stack(
//               children: <Widget>[
                // InkWell(
                //   : () {
                //     userPrefernece.remove().then((value) {
                //       Navigator.pushNamed(context, RoutesName.login);
                //     });
                //   },
                //   child: Center(
                //     child: Text('Гарах'),
                //   ),
                // ),
//               ],
//             ),
//           )
//         ],
//       ),
//       drawer: Drawer(
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [
//                 0.0,
//                 1.0
//               ],
//                   colors: [
//                 Theme.of(context).primaryColor.withOpacity(0.2),
//                 Theme.of(context).accentColor.withOpacity(0.5),
//               ])),
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     stops: [0.0, 1.0],
//                     colors: [
//                       Theme.of(context).primaryColor,
//                       Theme.of(context).accentColor,
//                     ],
//                   ),
//                 ),
//                 child: Container(
//                   alignment: Alignment.bottomLeft,
//                   child: Text(
//                     "Тохиргоо",
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.screen_lock_landscape_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Дахин ачааллах',
//                   style: TextStyle(
//                       fontSize: 17, color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.login_rounded,
//                     size: _drawerIconSize,
//                     color: Theme.of(context).accentColor),
//                 title: Text(
//                   'Нэвтрэх',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_add_alt_1,
//                     size: _drawerIconSize,
//                     color: Theme.of(context).accentColor),
//                 title: Text(
//                   'Бүртгүүлэх',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.password_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Нууц үг солих',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.verified_user_sharp,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Баталгаажуулах код',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
//                 },
//               ),
//               Divider(
//                 color: Theme.of(context).primaryColor,
//                 height: 1,
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.logout_rounded,
//                   size: _drawerIconSize,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 title: Text(
//                   'Гарах',
//                   style: TextStyle(
//                       fontSize: _drawerFontSize,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 : () {
//                   SystemNavigator.pop();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             // Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
//               padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(width: 5, color: Colors.white),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 20,
//                           offset: const Offset(5, 5),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.person,
//                       size: 80,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'Б.Анхболд',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'Тариаланч',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding:
//                               const EdgeInsets.only(left: 8.0, bottom: 4.0),
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             "Хэрэглэгчийн мэдээлэл",
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         Card(
//                           child: Container(
//                             alignment: Alignment.topLeft,
//                             padding: EdgeInsets.all(15),
//                             child: Column(
//                               children: <Widget>[
//                                 Column(
//                                   children: <Widget>[
//                                     ...ListTile.divideTiles(
//                                       color: Colors.grey,
//                                       tiles: [
//                                         ListTile(
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 12, vertical: 4),
//                                           leading: Icon(Icons.my_location),
//                                           title: Text("Байршил"),
//                                           subtitle: Text("Сэлэнгэ, Зүүнбүрэн"),
//                                         ),
//                                         ListTile(
//                                           leading: Icon(Icons.email),
//                                           title: Text("Емайл"),
//                                           subtitle: Text(
//                                               "softmaster.aagii@gmail.com"),
//                                         ),
//                                         ListTile(
//                                           leading: Icon(Icons.phone),
//                                           title: Text("Утас"),
//                                           subtitle: Text("976+89006176"),
//                                         ),
//                                         ListTile(
//                                           leading: Icon(Icons.person),
//                                           title: Text("Миний тухай"),
//                                           subtitle: Text(
//                                               "Мэргэжлийн агрономич. 15 жилийн туршлагатай"),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
