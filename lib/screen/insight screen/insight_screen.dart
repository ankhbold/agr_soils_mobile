import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/insight%20screen/indices_screen.dart';
import 'package:mvvm/screen/insight%20screen/weather_screen.dart';
import 'package:mvvm/screen/widgets/button/default_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

bool weather = true;

final ScrollController _firstController = ScrollController();
bool darsan = true;
List<String> text = [
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
  'Сэлэнгэ\n67 талбар',
];
List<String> texts = [
  'бүх талбай',
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
              DefaultButton(
                OnTap: () {
                  // setState(() {
                  Navigator.pushNamed(context, 'page2');
                  // });
                },
                text: 'Дэлгэрэнгүй харах',
              ),
              Container(height: 15, color: AppColors.grey),
              Chart(),
              DefaultButton(
                  OnTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChartPage()));
                  },
                  text: 'Бүгдийг харах'),
              Container(height: 15, color: AppColors.grey),
              AllFields(),
              DefaultButton(
                OnTap: () {
                  // setState(() {
                  Navigator.pushNamed(context, 'page3');
                  // });
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
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 10),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  height: MediaQuery.of(context).size.width * 0.15,
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
            decoration: BoxDecoration(
                gradient: current == index ? AppColors.grad : AppColors.gradi,
                // color:
                //     current == index ? const Color(0xff0f766e) : AppColors.grey,
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
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          text[index],
                          style: TextStyle(
                            color:
                                current == index ? Colors.white : Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
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
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
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
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.air),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Салхи\n(5 m/s)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.air),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Хур тунадас\n(0 mm)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.air),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Салхи\n(5 m/s)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.air),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Хур тунадас\n(0 mm)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              'Ургамалжилтын индэкс',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
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
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            texts[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: currents == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
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
                        fontSize: 15,
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

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  TrackballBehavior? _trackballBehavior;

  late TooltipBehavior _tooltipBehavior;
  Future<String> _loadSalesDataAsset() async {
    return rootBundle.loadString('assets/images/chart_data.json');
  }

  Future loadSalesData() async {
    final String jsonString =
        await _loadSalesDataAsset(); // Deserialization  step 1
    final dynamic jsonResponse =
        json.decode(jsonString); // Deserialization  step 2
    setState(() {
      // ignore: always_specify_types
      for (final Map<dynamic, dynamic> i in jsonResponse) {
        chartData!.add(_SampleData.fromJson(i)); // Deserialization step 3
      }
    });
  }

  @override
  void initState() {
    super.initState();
    chartData = <_SampleData>[];
    loadSalesData();
    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineColor: AppColors.Green,
        lineWidth: 15,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            borderWidth: 4,
            height: 10,
            width: 10,
            markerVisibility: TrackballVisibilityMode.visible));
  }

  List<_SampleData>? chartData;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2022, 10),
      ChartData(2024, 20),
      ChartData(2026, 30),
    ];
    return SfCartesianChart(
        key: GlobalKey(),
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: 'Сенсор мэдээлэл'),
        legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
        primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            intervalType: DateTimeIntervalType.months,
            dateFormat: DateFormat.m(),
            name: 'Сар',
            majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            rangePadding: ChartRangePadding.none,
            name: '...',
            minimum: 70,
            maximum: 110,
            interval: 10,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(color: Colors.transparent)),
        series: _getDefaultLineSeries(),
        trackballBehavior: _trackballBehavior);

    // return SfCartesianChart(
    //     plotAreaBorderWidth: 0,
    //     primaryXAxis: DateTimeAxis(
    //         // edgeLabelPlacement: EdgeLabelPlacement.shift,
    //         // intervalType: DateTimeIntervalType.years,
    //         // dateFormat: DateFormat.y(),
    //         // name: 'Years',
    //         majorGridLines: const MajorGridLines(width: 0)),
    //     primaryYAxis: NumericAxis(
    //         rangePadding: ChartRangePadding.none,
    //         name: 'Price',
    //         minimum: 70,
    //         maximum: 110,
    //         interval: 10,
    //         axisLine: const AxisLine(width: 0),
    //         majorTickLines: const MajorTickLines(color: Colors.transparent)),
    //     title: ChartTitle(text: 'Сенсор мэдээлэл'),
    //     tooltipBehavior: _tooltipBehavior,
    //     trackballBehavior: _trackballBehavior,
    //     series: <ChartSeries>[
    //       // Renders line chart
    //       LineSeries<ChartData, int>(
    //           dataSource: chartData,
    //           xValueMapper: (ChartData data, _) => data.x,
    //           yValueMapper: (ChartData data, _) => data.y)
    //     ]);
  }

  List<LineSeries<_SampleData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_SampleData, DateTime>>[
      LineSeries<_SampleData, DateTime>(
        dataSource: chartData!,
        xValueMapper: (_SampleData sales, _) => sales.x,
        yValueMapper: (_SampleData sales, _) => sales.y1,
        name: 'Product A',
      ),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сенсор мэдээлэл'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.grad,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Chart();
          },
        ),
      ),
    );
  }
}

class _SampleData {
  _SampleData(this.x, this.y1, this.y2);
  factory _SampleData.fromJson(Map<dynamic, dynamic> parsedJson) {
    return _SampleData(
      DateTime.parse(parsedJson['x']),
      parsedJson['y1'],
      parsedJson['y2'],
    );
  }
  DateTime x;
  num y1;
  num y2;
}
