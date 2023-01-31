import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/floatingss/floating_items.dart';
import 'package:mvvm/screen/field%20screen/floatingss/first_float.dart';

class FloatingFields extends StatelessWidget {
  const FloatingFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.03,
              ),
              child: myTabs[current]),

          // SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    );
  }
}

final List<Tab> Tabss = <Tab>[
  const Tab(
    child: FloatingFields(),
  ),
  Tab(
    child: FloatingItem(),
  ),
];

final List<Tab> Tabs = <Tab>[
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
];

int current = 0;

class Rectangular extends StatelessWidget {
  const Rectangular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45,
            child: Image.asset(
              'assets/images/ones.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
