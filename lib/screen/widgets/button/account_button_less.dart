import 'package:flutter/material.dart';

class AccountButtonLess extends StatelessWidget {
  final Icon icon;
  final Text text;

  const AccountButtonLess({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          icon,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.5, child: text),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
          ),
        ],
      ),
    );
  }
}
