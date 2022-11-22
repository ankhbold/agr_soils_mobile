import 'package:flutter/material.dart';
import 'package:mvvm/screen/field.dart';
import 'package:mvvm/screen/profile_screen.dart';

import '../constants/color.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.Green,
          ),
          child: Icon(
            Icons.add,
            color: note ? Colors.white : Colors.green,
          ),
        ));
  }
}

class addHeader extends StatelessWidget {
  const addHeader({
    Key? key,
    required this.screenwidth,
  }) : super(key: key);

  final double screenwidth;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: screenwidth * 0.18,
          child: Center(
              child: Container(
            height: screenHeight * 0.05,
            child: TextButton(
              onPressed: () {
                note = !note;
              },
              child: Text(
                'Буцах',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.Green,
                ),
              ),
            ),
          )),
        ),
        Container(
          width: screenwidth * 0.55,
          child: Center(
            child: Text(
              'Тэмдэглэл',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          width: screenwidth * 0.22,
          child: Center(
              child: Container(
            height: screenHeight * 0.05,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Хадгалах',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.Green,
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}

class NotesTextField extends StatelessWidget {
  const NotesTextField({
    Key? key,
    required this.screenHeight,
    required this.screenwidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenwidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.125,
      width: screenwidth * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Line4(),
          TextField(
            decoration: InputDecoration(
              hintText: 'Таны тэмдэглэл...',
              border: InputBorder.none,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Line4()
        ],
      ),
    );
  }
}
