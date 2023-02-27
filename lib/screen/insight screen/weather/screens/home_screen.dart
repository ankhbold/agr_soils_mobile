import 'package:flutter/material.dart';

import '../model/weather_model.dart';
import '../services/data_services.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final ApiResponse dataState = ApiResponse();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
        future: dataState.getWeather(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Day ${(snapshot.data!.main.tempMax - 273.15).toInt()}° ↑ • Night ${(snapshot.data!.main.tempMin - 273.15).toInt()}° ↓',
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${(snapshot.data!.main.temp - 273.15).toInt()}°',
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.network(
                                          'http://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon}.png',
                                          height: 40,
                                        ),
                                        snapshot.data!.weather[0].description
                                                .contains(' ')
                                            ? Text(
                                                '${snapshot.data!.weather[0].description.split(' ')[0][0].toUpperCase()}${snapshot.data!.weather[0].description.split(' ')[0].substring(1)}\n${snapshot.data!.weather[0].description.split(' ')[1][0].toUpperCase()}${snapshot.data!.weather[0].description.split(' ')[1].substring(1)}',
                                                textAlign: TextAlign.center,
                                              )
                                            : Text(
                                                snapshot.data!.weather[0]
                                                        .description[0]
                                                        .toUpperCase() +
                                                    snapshot.data!.weather[0]
                                                        .description
                                                        .substring(1),
                                                textAlign: TextAlign.center,
                                              ),
                                        const SizedBox(height: 5.0)
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  'Feels like ${(snapshot.data!.main.feelsLike - 273.15).toInt()}°',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: null,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "  Humidity",
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.main.humidity}%",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: null,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "  Visibility",
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data!.visibility
                                                        .toString() ==
                                                    'null'
                                                ? 'N/A'
                                                : '${snapshot.data!.visibility} m',
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: null,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.purpleAccent),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "  Wind",
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.wind.speed.toStringAsFixed(1)} km/h",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: null,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.pinkAccent),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "  Pressure",
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.main.pressure} hPa",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black),
                );
        },
      ),
    );
  }
}
