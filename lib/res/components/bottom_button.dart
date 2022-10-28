import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  const BottomButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          child: icon,
          onTap: () {
            onTap;
          },
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.008,
        // ),
        // Text(
        //   'тариалан',
        //   style: TextStyle(
        //     fontSize: 13,
        //     color: AppColors.Green,
        //   ),
        // ),
      ],
    );
  }
}
