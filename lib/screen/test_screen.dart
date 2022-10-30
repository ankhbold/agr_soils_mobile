import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'field.dart';
import 'notes_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

List<String> items = [
  "1",
  "2",
  "3",
];
final List<Tab> myTabs = <Tab>[
  Tab(
    child: Container(
      color: Colors.red,
    ),
  ),
  Tab(
    child: Container(
      color: Colors.blue,
    ),
  ),
  Tab(
    child: Container(
      color: Colors.red,
    ),
  ),
];
int current = 0;

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.width * 0.28,
        width: MediaQuery.of(context).size.width * 0.93,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: EdgeInsets.all(5),
                      color: current == index ? Colors.green : Colors.blue,
                      width: 40,
                      height: 25,
                      child: Center(
                        child: Text(
                          items[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 30,
              color: Colors.green,
              child: myTabs[current],
            ),
          ],
        ),
      ),
    );
  }
}
