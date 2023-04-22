import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../widget/line.dart';
import 'field.dart';
import 'floating_fields.dart';
import 'floatingss/first_float.dart';
import 'ndvi_sheet_button.dart';

class FieldPanel extends StatefulWidget {
  final ScrollController controller;

  const FieldPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FieldPanel> createState() => _FieldPanelState();
}

class _FieldPanelState extends State<FieldPanel> {
  // final ApiResponse dataState = ApiResponse();
  @override
  void initState() {
    // ApiResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.22,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          bottom: 8,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 239, 239, 239)
                                  .withOpacity(0.85),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: click ? 2 : 0,
                                  color: AppColors.Green)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // click = !click;
                                clicked = index;
                              });
                            },
                            child: Ink(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Tabs[index],
                                    Text(
                                      'Nov 23',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                NdviButton(),
              ],
            ),
          ),
          Container(
            height: 580,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 253, 248),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              controller: widget.controller,
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.21,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Container(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(right: 50, left: 50),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ]))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Тэлэх талбай 3га',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  'add crop',
                                  style: TextStyle(
                                      fontSize: 15, color: AppColors.Green),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          GestureDetector(
                            child: const RemoveButton(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Line3(),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      );
}

class RemoveButton extends StatelessWidget {
  const RemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.remove_circle,
        color: Colors.black.withOpacity(0.5),
        size: 30,
      ),
      onPressed: () {
        click = !click;
        fclick = !fclick;
        isFirstWidgetVisible = true;
        isSecondWidgetVisible = false;
        isThirdWidgetVisible = false;
      },
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










