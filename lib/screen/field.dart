import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/res/components/field_sheet_button.dart';
import 'package:mvvm/res/components/round_sheet_button.dart';
import 'package:mvvm/res/components/season_sheet_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../res/components/panel_widget.dart';

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final MapType _currentMapType = MapType.satellite;
  late GoogleMapController _mapController;
  LatLng currentLocation = const LatLng(
    47.92424770803818,
    106.90079705604086,
  );
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
                  const Season(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const FieldsSheet(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  const RoundSheetButton(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // _buildMap(),

          SlidingUpPanel(
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
            body: Stack(children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 16.5,
                  ),
                  mapType: _currentMapType,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                ),
              ),
              Positioned(
                bottom: 350,
                left: 370,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  onPressed: () {},
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.Green,
                  ),
                ),
              ),
            ]),
          ),

          Positioned(
            bottom: fabHeight,
            child: const FloatingFab(),
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
  const Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  const Tab(
    child: FloatingSecondItem(),
  ),
  const Tab(
    child: FloatingThirdItem(),
  ),
  const Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  const Tab(
    child: FloatingSecondItem(),
  ),
  const Tab(
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
    const Color.fromARGB(255, 226, 203, 0),
    Colors.green,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color[index],
                  borderRadius: BorderRadius.circular(60),
                  // border: Border.all(
                  //   width: 0,
                  // ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                item[index],
                style: const TextStyle(fontSize: 14),
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
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
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
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
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
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
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
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
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
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
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
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
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
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Үүлтэй',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(129, 158, 158, 158),
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
        color: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.125,
      width: MediaQuery.of(context).size.width * 0.93,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.03,
              ),
              child: myTabs[current]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.052,
            width: MediaQuery.of(context).size.width * 0.925,
            child: ListView.builder(
              itemCount: 8,
              padding: const EdgeInsets.only(right: 3, left: 3),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.15),
                    color: current == index
                        ? const Color(0xff0f766e)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: AnimatedContainer(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        duration: const Duration(milliseconds: 250),
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
          // SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    );
  }
}
