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
        future: WeatherService().getWeather(latLng: widget.latLng),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
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
                                    '${(snapshot.data!.main!.temp! - 273.15).toInt()}°',
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
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getWeatherInfoWidget(
                                          label: 'Салхины хурд',
                                          value: snapshot.data!.wind!.speed!.toStringAsFixed(1).toString() + "м/c"),
                                      getWeatherInfoWidget(
                                          label: 'Агаарын чийгшил',
                                          value: snapshot.data!.main!.humidity!.toStringAsFixed(1).toString() + "%"),
                                      getWeatherInfoWidget(
                                          label: 'Хөрсний чийг',
                                          value: snapshot.data!.wind!.speed!.toStringAsFixed(1).toString() + "%"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getWeatherInfoWidget(
                                          label: 'Хөрсний темпратур',
                                          value: (snapshot.data!.main!.temp! - 273.15).toStringAsFixed(2) + " °C"),
                                      getWeatherInfoWidget(
                                        label: 'Үүлний масс',
                                        value: (snapshot.data?.clouds?.all ?? 0).toString() + ' %',
                                      ),
                                      getWeatherInfoWidget(
                                        label: 'Агаарын даралт',
                                        value: (snapshot.data!.main!.pressure).toString() + " мм",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
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

Widget getWeatherInfoWidget({String? label, String? value}) {
  return Text(
    '${label}:${value}',
    style: TextStyle(
      fontSize: 12,
      color: Color(0xff717171),
    ),
    textAlign: TextAlign.start,
  );
}
