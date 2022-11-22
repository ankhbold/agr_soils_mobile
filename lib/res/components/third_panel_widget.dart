import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../screen/profile_screen.dart';
import '../../widget/note_add_button.dart';

class ThirdPanelWidget extends StatefulWidget {
  final ScrollController controller;

  const ThirdPanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ThirdPanelWidget> createState() => _ThirdPanelWidgetState();
}

class _ThirdPanelWidgetState extends State<ThirdPanelWidget> {
  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          controller: widget.controller,
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                buildNavigator(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.012,
                ),
                addHeader(screenwidth: MediaQuery.of(context).size.width),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // SizedBox(
                //   height: screenHeight * 0.03,
                // ),
                NotesTextField(
                  screenHeight: MediaQuery.of(context).size.height,
                  screenwidth: MediaQuery.of(context).size.width,
                ),
                InkWell(
                    child: Ink(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: AppColors.Green,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        'Зураг оруулахh',
                        style: TextStyle(
                            color: AppColors.Green,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Line3(),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: const Color.fromARGB(255, 240, 240, 240),
            )
          ],
        ),
      );
}

Widget buildNavigator() => Container(
      padding: const EdgeInsets.only(right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
