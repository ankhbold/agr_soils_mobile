import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/profile_screen.dart';
import 'package:mvvm/widget/floating_widget.dart';

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
String formattedDate = DateFormat('H a, MMMM d').format(now);

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 226, 225, 225),
          title: Text(
            // DateFormat.j().format(DateTime.now()) +
            formattedDate,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Line3(),
            ChooseLoc(),
            Weather(),
            Container(
              height: 15,
              color: Color.fromARGB(255, 226, 225, 225),
            ),
            AllFields(),
          ],
        ));
  }
}

class ChooseLoc extends StatelessWidget {
  const ChooseLoc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                height: MediaQuery.of(context).size.height * 0.08,
                child: RawScrollbar(
                  thumbColor: AppColors.Green,
                  thickness: 4,
                  // interactive: true,
                  thumbVisibility: true,
                  controller: _firstController,
                  child: Near(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  child: Ink(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 50,
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
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.26,
            height: MediaQuery.of(context).size.height * 0.01,
            decoration: BoxDecoration(
                color: current == index
                    ? const Color(0xff0f766e)
                    : Color.fromARGB(255, 209, 213, 214),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text[index],
                        style: TextStyle(
                          color: current == index ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
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
                  '-13*',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Line2(),
          InkWell(
            child: Ink(
              height: 50,
              child: Center(
                child: Text(
                  'Extended forecast',
                  style: TextStyle(
                    color: AppColors.Green,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Line3()
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
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Field vegetation indices',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.77,
            height: MediaQuery.of(context).size.height * 0.06,
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
                    child: Ink(
                      decoration: BoxDecoration(
                          color: currents == index
                              ? const Color(0xff0f766e)
                              : Color.fromARGB(255, 209, 213, 214),
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
          ListView(
            children: [
              ListTile(
                title: Image(image: AssetImage('')),
              )
            ],
          )
        ],
      ),
    );
  }
}
