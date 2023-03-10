import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// LatLng(latitude:49.981314, longitude:105.826702)
double lat = 49.981314;
double lon = 105.826702;
final LatLong = LatLng(49.981314, 105.826702);

class ApiResponse {
  Future<Weather> getWeather() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${LatLong.latitude}&lon=${LatLong.longitude}&APPID=6adf87802066a3ee22591eb3f8abfe0c';
    final response = await http.get(Uri.parse(url));
    return Weather.fromJson(json.decode(response.body));
  }
}

class Weathers extends StatefulWidget {
  const Weathers({super.key});

  @override
  State<Weathers> createState() => _WeathersState();
}

class _WeathersState extends State<Weathers> {
  final ApiResponse dataState = ApiResponse();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: dataState.getWeather(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                                    '${(snapshot.data!.main.temp - 273.15).toInt()}°',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.air,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Салхи\n${snapshot.data!.wind.speed.toStringAsFixed(1)} km/h",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Row(
                                        children: [
                                          // Icon(Icons.air),
                                          // SizedBox(
                                          //   width: 2,
                                          // ),
                                          Text(
                                            'Чийгшил\n${snapshot.data!.main.humidity.toStringAsFixed(1)} %',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         Icon(Icons.air),
                                  //         SizedBox(
                                  //           width: 2,
                                  //         ),
                                  //         Text(
                                  //           'Салхи\n(5 m/s)',
                                  //           style: TextStyle(fontSize: 13),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       width: 15,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         Icon(Icons.air),
                                  //         SizedBox(
                                  //           width: 2,
                                  //         ),
                                  //         Text(
                                  //           'Хур тунадас\n(0 mm)',
                                  //           style: TextStyle(fontSize: 13),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black),
                );
        });
  }
}

class WeatherClick extends StatefulWidget {
  const WeatherClick({super.key});

  @override
  State<WeatherClick> createState() => _WeatherClickState();
}

class _WeatherClickState extends State<WeatherClick> {
  final ApiResponse dataState = ApiResponse();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: dataState.getWeather(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                                    '${(snapshot.data!.main.temp - 273.15).toInt()}°',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.air,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Салхи\n${snapshot.data!.wind.speed.toStringAsFixed(1)} km/h",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Row(
                                        children: [
                                          // Icon(Icons.air),
                                          // SizedBox(
                                          //   width: 2,
                                          // ),
                                          Text(
                                            'Чийгшил\n${snapshot.data!.main.humidity.toStringAsFixed(1)} %',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         Icon(Icons.air),
                                  //         SizedBox(
                                  //           width: 2,
                                  //         ),
                                  //         Text(
                                  //           'Салхи\n(5 m/s)',
                                  //           style: TextStyle(fontSize: 13),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       width: 15,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         Icon(Icons.air),
                                  //         SizedBox(
                                  //           width: 2,
                                  //         ),
                                  //         Text(
                                  //           'Хур тунадас\n(0 mm)',
                                  //           style: TextStyle(fontSize: 13),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black),
                );
        });
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
