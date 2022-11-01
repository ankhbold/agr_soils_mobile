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
      body: Container(),
    );
  }
}
