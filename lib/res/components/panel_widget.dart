import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

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
            height: 217,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.flag_circle_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Талбайгаа нэмнэ үү',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: const Text(
                    'Та NDVI индексийг хянах, тэмдэглэл бичих, газар тариалангийн эргэлтийг бүртгэх болон бусад олон..',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 2,
            width: 500,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              child: const Center(
                child: Text(
                  'Талбай нэмэх',
                  style: TextStyle(
                      color: AppColors.Green, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
