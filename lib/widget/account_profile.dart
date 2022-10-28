import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AccountProfile extends StatelessWidget {
  AccountProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: 30,
          width: 60,
          child: InkWell(
            onTap: () {
              userPrefernece.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Center(
              child: Text(
                'Гарах',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('profile'),
      ),
    );
  }
}
