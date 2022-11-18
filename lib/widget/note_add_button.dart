import 'package:flutter/material.dart';
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
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
            color: AppColors.Green, borderRadius: BorderRadius.circular(60)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => ListView(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  addHeader(screenwidth: screenwidth),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.03,
                  // ),
                  NotesTextField(
                    screenHeight: screenHeight,
                    screenwidth: screenwidth,
                  ),
                  InkWell(
                      child: Ink(
                    width: screenwidth * 0.9,
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: AppColors.Green,
                        ),
                        SizedBox(
                          width: screenwidth * 0.02,
                        ),
                        Text(
                          'Зураг оруулах',
                          style: TextStyle(
                              color: AppColors.Green,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Line3(),
                  Container(
                    height: screenHeight * 0.5,
                    color: const Color.fromARGB(255, 240, 240, 240),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
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
          width: screenwidth * 0.19,
          child: Center(
              child: Container(
            height: screenHeight * 0.05,
            child: TextButton(
              onPressed: () {},
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
          width: screenwidth * 0.21,
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
      height: screenHeight * 0.1,
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
            height: screenHeight * 0.03,
          ),
          Line4()
        ],
      ),
    );
  }
}
