import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/field.dart';
import 'package:mvvm/screen/home_screen.dart';

import '../../screen/profile_screen.dart';
import '../../screen/widgets/add_note.dart';
import '../../widget/note_add_button.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;

  const PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.Green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          controller: widget.controller,
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            buildNavigator(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.012,
            ),
            buildTextField(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 90,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 7,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Тариалан',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '0 ha out of 0 ha',
                              style: TextStyle(
                                  color: Color.fromARGB(95, 255, 255, 255),
                                  fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Газар тариалан үүсгэх',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffB7B7B7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                    ],
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      height: 20,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 227, 231),
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildMyFields(),
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
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );

Widget buildTextField() => Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.only(),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: AppColors.Green,
                  ),
                  border: InputBorder.none,
                  hintText: 'Хайлтын утгаа оруулна уу',
                ),
              ),
            ),
          ),
        ],
      ),
    );
Widget buildPlanted() => SizedBox(
      height: 90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 7,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Тариалан',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '0 ha out of 0 ha',
                      style: TextStyle(
                          color: Color.fromARGB(95, 255, 255, 255),
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 113,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Газар тариалан үүсгэх',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
          Container(
            child: Container(
              width: 400,
              height: 20,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 227, 231),
                  borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ],
      ),
    );

Widget buildMyFields() => Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Миний талбай',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 60,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ургамлын индексээр',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      click = !click;
                      clicks = !clicks;
                    },
                    child: Roow()),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      click = !click;
                      clicks = !clicks;
                    },
                    child: Roow()),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      click = !click;
                      clicks = !clicks;
                    },
                    child: Roow()),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      click = !click;
                      clicks = !clicks;
                    },
                    child: Roow()),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );

class Roow extends StatelessWidget {
  const Roow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click = !click;
        clicks = !clicks;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.18,
            child: Image.asset(
              'assets/images/ones.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Тэлэх талбай 15 га',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'Буудай',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Column(
            children: [
              const Text(
                '0.14',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    '-0.01',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PanelWidget2 extends StatefulWidget {
  final ScrollController controller;

  PanelWidget2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PanelWidget2> createState() => _PanelWidget2State();
}

class _PanelWidget2State extends State<PanelWidget2> {
  @override
  Widget build(BuildContext context) => ListView(
          controller: widget.controller,
          padding: EdgeInsets.zero,
          children: [
            NoteAdd(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.6,
            //   child: Center(
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.02,
            //         ),
            //         Center(
            //           child: Container(
            //             height: 5,
            //             width: 50,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(25),
            //               color: Colors.black,
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.02,
            //         ),
            //         addHeader(screenwidth: MediaQuery.of(context).size.width),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.02,
            //         ),
            //         // SizedBox(
            //         //   height: screenHeight * 0.03,
            //         // ),
            //         NotesTextField(
            //           screenHeight: MediaQuery.of(context).size.height,
            //           screenwidth: MediaQuery.of(context).size.width,
            //         ),
            //         InkWell(
            //             child: Ink(
            //           width: MediaQuery.of(context).size.width * 0.9,
            //           child: Row(
            //             children: [
            //               Icon(
            //                 Icons.camera_alt,
            //                 color: AppColors.Green,
            //               ),
            //               SizedBox(
            //                 width: MediaQuery.of(context).size.width * 0.02,
            //               ),
            //               Text(
            //                 'Зураг оруулах',
            //                 style: TextStyle(
            //                     color: AppColors.Green,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //             ],
            //           ),
            //         )),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.02,
            //         ),
            //         Line3(),
            //         Container(
            //           height: MediaQuery.of(context).size.height * 0.5,
            //           color: const Color.fromARGB(255, 240, 240, 240),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ]);
}
