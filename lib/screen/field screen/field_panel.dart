import 'dart:convert';

import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../widget/line.dart';
import '../insight%20screen/weather.dart';
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
  final ApiResponse dataState = ApiResponse();
  @override
  void initState() {
    ApiResponse();
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
                WeatherClick(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      );
}

// class RemoveButton extends StatefulWidget {
//   const RemoveButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<RemoveButton> createState() => _RemoveButtonState();
// }

// class _RemoveButtonState extends State<RemoveButton> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         Icons.remove_circle,
//         color: Colors.black.withOpacity(0.5),
//         size: 30,
//       ),
//       onPressed: () {
//         setState(() {
//           click = !click;
//           fclick = !fclick;
//           isFirstWidgetVisible = true;
//           isSecondWidgetVisible = false;
//           isThirdWidgetVisible = false;
//         });
//       },
//     );
//   }
// }
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

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
  });

  final Coord coord;
  final List<WeatherElement> weather;
  final Main main;
  final int visibility;
  final Wind wind;
  final String name;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: Coord.fromJson(json["coord"]),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "name": name,
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  final int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class WeatherElement {
  WeatherElement({
    required this.id,
    required this.description,
    required this.icon,
  });

  final int id;
  final String description;
  final String icon;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
