import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;

  PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
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
            SizedBox(
              height: 10,
            ),
            buildPlanted(),
            SizedBox(
              height: 10,
            ),
            buildMyFields(),
          ],
        ),
      );
}

Widget buildNavigator() => Container(
      padding: EdgeInsets.only(right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );

Widget buildTextField() => Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
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
Widget buildPlanted() => Container(
      height: 90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 7,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                width: 113,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Create crop rotation',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
          Container(
            child: Container(
              width: 400,
              height: 20,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 227, 231),
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
              SizedBox(
                width: 5,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              SizedBox(
                width: 60,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Ургамлын индексээр',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
          Container(
            height: 217,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.flag_circle_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Талбайгаа нэмнэ үү',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Text(
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
          SizedBox(
            height: 30,
          ),
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 2,
            width: 500,
          ),
          SizedBox(
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
              child: Center(
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
