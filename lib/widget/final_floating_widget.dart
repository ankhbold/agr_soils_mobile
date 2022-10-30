import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FloatingFab extends StatefulWidget {
  const FloatingFab({super.key});

  @override
  State<FloatingFab> createState() => _FloatingFabState();
}

List<String> items = [
  "1",
  "2",
  "3",
  "1",
  "2",
  "3",
  "1",
  "2",
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

class _FloatingFabState extends State<FloatingFab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.width * 0.28,
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.91,
            child: ListView.builder(
              itemCount: 8,
              padding: EdgeInsets.all(3),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: current == index
                        ? Color(0xff0f766e)
                        : Color(0xffB1B1B1),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        child: Text(
                          items[index],
                          style: TextStyle(
                            color:
                                current == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
