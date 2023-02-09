import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color.fromARGB(255, 240, 240, 240);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color green = Color(0xff004D40);
  static const Color Green = Color(0xff00796B);
  static const Color Black = Color.fromARGB(255, 0, 0, 0);
  static const Color Unactive = Color.fromARGB(255, 105, 105, 105);
  static const Color grey = Color.fromARGB(255, 221, 228, 229);
  static const Gradient grad = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.Green,
      // AppColors.Green,
      AppColors.green,
    ],
  );

  //HexColor('#0f766e')
}

class myTextStyleBase {
  static const size_A = TextStyle(fontSize: 10);
  static const size_B = TextStyle(fontSize: 30);
}
