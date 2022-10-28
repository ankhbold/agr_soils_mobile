import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final Widget title;

  IntroPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              title,
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
