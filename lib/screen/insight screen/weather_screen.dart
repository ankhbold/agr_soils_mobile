import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/color.dart';
import '../../widget/line.dart';
import '../insight%20screen/insight_screen.dart';
import '../insight%20screen/weather.dart';

final ScrollController _scrollController = ScrollController();

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });

    super.initState();
  }

  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0.5),
                blurRadius: 0.1,
              )
            ]),
            child: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              backgroundColor: AppColors.grey,
              elevation: 0.0,
              title: Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: Column(
          children: [
            Visibility(
              visible: _isVisible,
              child: Column(
                children: [
                  ChooseLocc(),
                  Weathers(),
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(
                      // top: 15,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'хур тунадасны хэмжээ, магадлал',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text('цаг'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text('хэмжээ'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text('магадлал'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Line3(),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: AppColors.grey,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Өнөөдөр,$formatDate',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.sunny,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 183, 59),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      '-16',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    'үүлэрхэг',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 68, 98, 110),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                      Text('Салхи\n(5 m/s)'),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Line3(),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}

class WeatherWide extends StatelessWidget {
  const WeatherWide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 20,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: Color.fromARGB(255, 255, 196, 0),
                  size: 60,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '-13',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    Icon(Icons.air),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Салхи\n(5 m/s)',
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Хур тунадас\n(0 mm)',
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 22,
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Spraying time. ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Гэж юу вэ?',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.015,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.6, 0.9],
                      colors: [
                        AppColors.grey,
                        AppColors.Green,
                        AppColors.Black,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('3:00 pm'),
                      Text('9:00 pm'),
                      Text('3:00 am'),
                      Text('9:00 am'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseLocc extends StatefulWidget {
  const ChooseLocc({super.key});

  @override
  State<ChooseLocc> createState() => _ChooseLoccState();
}

class _ChooseLoccState extends State<ChooseLocc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                height: MediaQuery.of(context).size.height * 0.062,
                child: RawScrollbar(
                  thumbColor: AppColors.Green,
                  thickness: 4,
                  radius: Radius.circular(100),
                  // interactive: true,

                  thumbVisibility: true,
                  controller: _scrollController,
                  child: Near(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WeatherScreen(),
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                      // color: AppColors.Green,
                      gradient: AppColors.grad,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

// class Nearr extends StatefulWidget {
//   const Nearr({super.key});

//   @override
//   State<Nearr> createState() => _NearrState();
// }

// class _NearrState extends State<Nearr> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       itemCount: text.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.29,
//             height: MediaQuery.of(context).size.height * 0.01,
//             decoration: BoxDecoration(
//                 color:
//                     current == index ? const Color(0xff0f766e) : AppColors.grey,
//                 borderRadius: BorderRadius.circular(8)),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       current = index;
//                     });
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         text[index],
//                         style: TextStyle(
//                           color: current == index ? Colors.white : Colors.black,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
