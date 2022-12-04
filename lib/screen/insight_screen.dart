import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/profile_screen.dart';
import 'package:mvvm/screen/weather_screen.dart';

bool weather = true;

final ScrollController _firstController = ScrollController();
bool darsan = true;
List<String> text = [
  'Надтай ойрхон\nбайхгүй',
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
];
List<String> texts = [
  'бүх талбар',
  'Буудай',
];

int current = 0;
int currents = 0;
DateTime now = DateTime.now();
String formattedDate = DateFormat('M сарын d (H цаг)').format(now);
String formatDate = DateFormat('M сарын d').format(now);

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Color.fromARGB(255, 226, 225, 225),
      // appBar: PreferredSize(
      //   child: Container(
      //     decoration: BoxDecoration(boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey,
      //         offset: Offset(0, 0.5),
      //         blurRadius: 0.1,
      //       )
      //     ]),
      //     child:
      //      AppBar(
      //       backgroundColor: AppColors.grey,
      //       elevation: 0.0,
      //       title: Text(
      //         formattedDate,
      //         style: TextStyle(
      //           color: Colors.black,
      //         ),
      //       ),
      //     ),
      //   ),
      //   preferredSize: Size.fromHeight(kToolbarHeight),
      // ),
      body: Navigator(
        onGenerateRoute: (insight) {
          Widget page = const Insight();
          if (insight.name == 'page2') page = const WeatherScreen();
          if (insight.name == 'page3') page = const IndicesScreen();
          if (insight.name == 'page1') page = const Insight();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}

class Insight extends StatefulWidget {
  const Insight({
    Key? key,
  }) : super(key: key);

  @override
  State<Insight> createState() => _InsightState();
}

class _InsightState extends State<Insight> {
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
        body: Container(
          color: AppColors.whiteColor,
          child: ListView(
            children: [
              ChooseLoc(),
              Weather(),
              Container(height: 15, color: AppColors.grey),
              AllFields(),
              DefaultButton(
                OnTap: () {
                  setState(() {
                    Navigator.pushNamed(context, 'page3');
                  });
                },
                text: 'Бүгдийг харах',
              ),
            ],
          ),
        ));
  }
}

class ChooseLoc extends StatefulWidget {
  const ChooseLoc({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseLoc> createState() => _ChooseLocState();
}

class _ChooseLocState extends State<ChooseLoc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    controller: _firstController,
                    child: Near(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
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
                        color: AppColors.Green,
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
        ],
      ),
    );
  }
}

class Near extends StatefulWidget {
  const Near({super.key});

  @override
  State<Near> createState() => _NearState();
}

class _NearState extends State<Near> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _firstController,
      itemCount: text.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.29,
            height: MediaQuery.of(context).size.height * 0.01,
            decoration: BoxDecoration(
                color:
                    current == index ? const Color(0xff0f766e) : AppColors.grey,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Ink(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text[index],
                          style: TextStyle(
                            color:
                                current == index ? Colors.white : Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.235,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
          DefaultButton(
            OnTap: () {
              setState(() {
                Navigator.pushNamed(context, 'page2');
              });
            },
            text: 'Дэлгэрэнгүй харах',
          )
        ],
      ),
    );
  }
}

class Indices extends StatefulWidget {
  const Indices({super.key});

  @override
  State<Indices> createState() => _IndicesState();
}

class _IndicesState extends State<Indices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }
}

class AllFields extends StatefulWidget {
  const AllFields({super.key});

  @override
  State<AllFields> createState() => _AllFieldsState();
}

class _AllFieldsState extends State<AllFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
            ),
            child: Text(
              'Ургамалуудын индэкс',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21,
                // letterSpacing: 0,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.77,
            height: MediaQuery.of(context).size.height * 0.055,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currents = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: currents == index
                              ? const Color(0xff0f766e)
                              : AppColors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                        child: Text(
                          texts[index],
                          style: TextStyle(
                            color:
                                currents == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Roow(),
              Roow(),
              Roow(),
            ],
          ),
        ],
      ),
    );
  }
}

class Roow extends StatelessWidget {
  const Roow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 5,
        right: 7,
        left: 7,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.02,
            // ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Image.asset(
                      'assets/images/ones.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Тэлэх талбай 15 га',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      'Буудай',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0,
            ),
            Column(
              children: [
                Text(
                  formatDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      '-0.01',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatefulWidget {
  final VoidCallback OnTap;
  final String text;
  DefaultButton({super.key, required this.OnTap, required this.text});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.OnTap,
      child: Ink(
        child: Column(
          children: [
            Line2(),
            Container(
              height: 50,
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Line2()
          ],
        ),
      ),
    );
  }
}

class IndicesScreen extends StatefulWidget {
  const IndicesScreen({super.key});

  @override
  State<IndicesScreen> createState() => _IndicesScreenState();
}

class _IndicesScreenState extends State<IndicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('fsdf'))),
    );
  }
}
