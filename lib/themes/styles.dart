import 'package:flutter/material.dart';

const primaryColor = Colors.black;
const disabledColor = Color(0xffA2A2A6);
final appTheme = ThemeData(
  brightness: Brightness.light,
  typography: Typography.material2021(),
  useMaterial3: true,
  bottomSheetTheme: const BottomSheetThemeData(modalBackgroundColor: Colors.white, backgroundColor: Colors.white),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xfff2f2f2),
  buttonBarTheme: const ButtonBarThemeData(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  buttonTheme: const ButtonThemeData(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffF2F2F2),
    elevation: 0.2,
    centerTitle: false,
    // color: const Color(0xffF2F2F2),
    iconTheme: IconThemeData(color: Color(0xffA0A0A0)),
    titleTextStyle: TextStyle(
      fontFamily: 'GIP',
      fontSize: 17,
      color: Color(0xff000000),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'GIP',
  backgroundColor: const Color(0xfff2f2f2),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'GIP', fontSize: 96, color: primaryColor, fontWeight: FontWeight.w300),
    displayMedium: TextStyle(fontFamily: 'GIP', fontSize: 60, color: primaryColor, fontWeight: FontWeight.w300),
    displaySmall: TextStyle(fontFamily: 'GIP', fontSize: 48, color: primaryColor, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontFamily: 'GIP', fontSize: 34, color: primaryColor, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontFamily: 'GIP', fontSize: 24, color: primaryColor, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontFamily: 'GIP', fontSize: 20, color: primaryColor, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontFamily: 'GIP', fontSize: 12, color: primaryColor, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontFamily: 'GIP', fontSize: 14, color: primaryColor, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(fontFamily: 'GIP', fontSize: 16, color: primaryColor, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(fontFamily: 'GIP', fontSize: 14, color: primaryColor, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontFamily: 'GIP', fontSize: 10, color: primaryColor, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontFamily: 'GIP', fontSize: 16, color: primaryColor, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontFamily: 'GIP', fontSize: 14, color: primaryColor, fontWeight: FontWeight.w400),
  ),
  primaryColor: primaryColor,
);
