import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/res/components/field_sheet_button.dart';
import 'package:mvvm/res/components/round_sheet_button.dart';
import 'package:mvvm/res/components/season_sheet_button.dart';
import 'package:mvvm/screen/notes_screen.dart';
import 'package:mvvm/screen/test_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../res/components/panel_widget.dart';
import '../widget/floating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/geo/crs/crs.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:flutter_map/src/map/map.dart';
import 'package:latlong2/latlong.dart';

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  static double fabHeightClosed = 95.0;
  double fabHeight = fabHeightClosed;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    final panelHeightClosed = MediaQuery.of(context).size.height * 0.085;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.65;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.035,
                  ),
                  Season(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  FieldsSheet(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  RoundSheetButton(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              ),
              SizedBox(
                height: 0,
              )
            ],
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _buildMap(),
          Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightOpened,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => PanelWidget(
                controller: controller,
              ),
              onPanelSlide: (position) => setState(() {
                final panelMaxScrollExtent =
                    panelHeightOpened - panelHeightClosed;
                fabHeight =
                    position * panelMaxScrollExtent + panelHeightClosed + 10;
              }),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: _buildMap(),
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       // image:
              //       // DecorationImage(
              //       //   image: AssetImage("assets/images/map2.jpg"),
              //       //   fit: BoxFit.cover,
              //       // ),
              //       ),
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: MediaQuery.of(context).size.width * 0.1,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.035,
              // ),
              // Season(),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.25,
              // ),
              // FieldsSheet(),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.02,
              // ),
              // RoundSheetButton(),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ),
          Positioned(
            bottom: fabHeight,
            child: FloatingFab(),
          ),
        ],
      ),
    );
  }
}

class FloatingFab extends StatefulWidget {
  const FloatingFab({super.key});

  @override
  State<FloatingFab> createState() => _FloatingFabState();
}

List<String> items = [
  "NDVI",
  "NDVI - ялгавартай",
  "Хур Тунадас",
  "Таримал",
  "Ургац/дундаж",
  "Үрэлсэн огноо",
  "Хураах огноо",
  "NDVI дундаж",
];
final List<Tab> myTabs = <Tab>[
  Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  Tab(
    child: FloatingSecondItem(),
  ),
  Tab(
    child: FloatingThirdItem(),
  ),
  Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  Tab(
    child: FloatingSecondItem(),
  ),
  Tab(
    child: FloatingThirdItem(),
  ),
];

class FloatingFourthItem extends StatelessWidget {
  FloatingFourthItem({
    Key? key,
  }) : super(key: key);

  @override
  List<String> item = [
    "Буудай",
    "Рапс",
    "Овъёос",
    "Арвай",
    "Тэжээлийн ургамал",
  ];
  List<Color> color = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.pink,
  ];

  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      width: 0.5,
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                item[index],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
        );
      },
    );
  }
}

class FloatingSecondItem extends StatelessWidget {
  const FloatingSecondItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.Green,
                              Colors.green,
                              Color.fromARGB(255, 89, 255, 95),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FloatingThirdItem extends StatelessWidget {
  const FloatingThirdItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 255, 190, 69),
                              Color.fromARGB(255, 255, 122, 69),
                              Color.fromARGB(255, 255, 94, 0),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FloatingItem extends StatelessWidget {
  const FloatingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.Green,
                              Colors.green,
                              Colors.yellow,
                              Colors.orange,
                              Colors.red,
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Үүлтэй',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(129, 158, 158, 158),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

int current = 0;

class _FloatingFabState extends State<FloatingFab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.03,
              ),
              child: myTabs[current]),
          Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.925,
            child: ListView.builder(
              itemCount: 8,
              padding: EdgeInsets.only(right: 3, left: 3),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: current == index
                        ? Color(0xff0f766e)
                        : Color(0xffB1B1B1),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: AnimatedContainer(
                        margin: EdgeInsets.only(left: 10, right: 10),
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
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   actions: [
// InkWell(
//     onTap: () {
//       userPrefernece.remove().then((value) {
//         Navigator.pushNamed(context, RoutesName.login);
//       });
//     },
//     child: Center(child: Text('Гарах'))),
// SizedBox(
//   width: 20,
// )
//   ],
// ),

FlutterMap _buildMap() {
  // ignore: unnecessary_new
  return FlutterMap(
    options: MapOptions(
      center: LatLng(50.093057, 105.715020),
      zoom: 9.2,
    ),
    nonRotatedChildren: [
      AttributionWidget.defaultWidget(
        source: 'OpenStreetMap contributors',
        onSourceTapped: null,
      ),
    ],
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      ),
    ],
  );
}
