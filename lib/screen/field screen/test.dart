import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/field%20screen/field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// import '../../constants/color.dart';
import 'floatingss/first_float.dart';
import 'floatingss/floating_items.dart';
import 'panel_widget.dart';

bool sungah = true;

class Testle extends StatefulWidget {
  const Testle({super.key});

  @override
  State<Testle> createState() => _TestleState();
}

class _TestleState extends State<Testle> {
  // final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.teal[700],
        appBar: AppBar(
          title: Text('sliding up'),
        ),
        body: SlidingUpPanel(
          maxHeight: 800,
          minHeight: 250,
          color: Colors.transparent,
          backdropEnabled: true,
          parallaxEnabled: true,
          // controller: panelController,
          parallaxOffset: .5,
          panelBuilder: (controller) {
            return Panelss(controller: controller);
          },
          body: PageView.builder(itemBuilder: ((context, index) {
            return Container(
              color: Color.fromARGB(255, 255, 220, 220),
            );
          })),
        ));
  }
}

class Panelss extends StatefulWidget {
  final ScrollController controller;

  const Panelss({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<Panelss> createState() => _PanelssState();
}

int current = 0;

class _PanelssState extends State<Panelss> {
  List<String> items = [
    "NDVI",
    "EVI",
    "Хур тунадас",
    "Таримлын төрөл",
    "Ургацын дундаж",
    "Тариалсан огноо",
    "Хураасан огноо",
  ];
  final List<Tab> myTabs = <Tab>[
    const Tab(
      child: FloatingItem(),
    ),
    Tab(
      child: FloatingFourthItem(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height2 = MediaQuery.of(context).size.height * 0.3;
    final height1 = MediaQuery.of(context).size.height * 0.1;

    // final panelHeightOpened = MediaQuery.of(context).size.height * 0.8;
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                sungah = !sungah;
              },
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.1,
                // width: MediaQuery.of(context).size.width * 0.975,
                height: 35, width: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.65),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: sungah
                    ? Icon(
                        Icons.arrow_upward,
                      )
                    : Icon(
                        Icons.arrow_downward,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: sungah ? height1 : height2,
              width: MediaQuery.of(context).size.width * 0.975,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.65),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 5,
                      left: 5,
                    ),
                    child: SizedBox(child: myTabs[current]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.925,
                    child: ListView.builder(
                      itemCount: 2,
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.055,
                          // width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.15),
                              // color: current == index
                              //     ? const Color(0xff0f766e)
                              //     : const Color.fromARGB(255, 255, 255, 255),
                              gradient: current == index
                                  ? AppColors.grad
                                  : AppColors.gradi),
                          child: Center(
                            child: GestureDetector(
                              child: AnimatedContainer(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                    color: current == index
                                        ? Colors.white
                                        : Colors.black,
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
            ),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.62,
              decoration: const BoxDecoration(
                // color: AppColors.Green,
                gradient: AppColors.grad,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Column(
                      children: [
                        CustomNavigator(),
                        Padding(
                          padding: EdgeInsets.only(right: 50, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        TextFieldField(),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 6,
                    flex: 4,
                    child: ListView(
                      controller: widget.controller,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Planted(),
                        const SizedBox(
                          height: 10,
                        ),
                        MyFields(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.015,
    );
  }
}

class MyFields extends StatelessWidget {
  const MyFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Roow(),
                SizedBox(
                  height: 20,
                ),
                Roow(),
                SizedBox(
                  height: 20,
                ),
                Roow(),
                SizedBox(
                  height: 20,
                ),
                Roow(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
