import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../models/weather/weather.dart';
import '../../services/weather.dart';
import '../../widget/loader.dart';


class Weathers extends StatefulWidget {
  Weathers({super.key, this.latLng});
  LatLng? latLng;

  @override
  State<Weathers> createState() => _WeathersState();
}

class _WeathersState extends State<Weathers> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: WeatherService().getWeather(),
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
                              width: MediaQuery.of(context).size.width * 0.365,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.sunny,
                                    color: Color.fromARGB(255, 255, 196, 0),
                                    size: 60,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${(snapshot.data!.main.temp - 273.15).toInt()}°',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
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
                                        width: 10,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : LoadingIndicatorWidget(
                  loaderColor: Colors.green,
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
  // final ApiResponse dataState = ApiResponse();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: WeatherService().getWeather(),
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: CircularProgressIndicator(backgroundColor: Colors.black),
                );
        });
  }
}







