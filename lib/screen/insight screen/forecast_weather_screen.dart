import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../constants/color.dart';
import '../../models/weather/weather.dart';
import '../../services/weather.dart';
import '../../utils/date_manager.dart';
import '../../widget/line.dart';
import '../../widget/loader.dart';
import '../insight%20screen/insight_screen.dart';
import 'weather.dart';

final ScrollController _scrollController = ScrollController();

// ignore: must_be_immutable
class ForecastWeatherScreen extends StatefulWidget {
  ForecastWeatherScreen({super.key, this.latLng});
  LatLng? latLng;

  @override
  State<ForecastWeatherScreen> createState() => ForecastWeatherScreenState();
}

class ForecastWeatherScreenState extends State<ForecastWeatherScreen> {
  DateTime currentDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

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
      body: FutureBuilder(
          future: WeatherService().getForecastWeather(latLng: widget.latLng),
          builder: (context, AsyncSnapshot<List<Weather>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 30),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime weatherDateTime = DateTime.parse(snapshot.data![index].dt_txt!);
                    bool isLast = index == snapshot.data!.length - 1;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: index == 0
                            ? BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )
                            : isLast
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                                : BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ((weatherDateTime.year == currentDate.year &&
                                                weatherDateTime.month == currentDate.month &&
                                                currentDate.day == weatherDateTime.day)
                                            ? "Өнөөдөр"
                                            : MyDateManager.getDayName(day: weatherDateTime.weekday)) +
                                        " " +
                                        (MyDateManager.toClientDateTime(
                                            date: weatherDateTime.toString(), noTime: true)),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          '${(snapshot.data![index].main!.temp! - 273.15).toInt()}°',
                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(color: Color.fromARGB(255, 68, 98, 110), fontSize: 15),
                                      ),
                                    ],
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
                                                value:
                                                    snapshot.data![index].wind!.speed!.toStringAsFixed(1).toString() +
                                                        "м/c"),
                                            getWeatherInfoWidget(
                                                label: 'Агаарын чийгшил',
                                                value: snapshot.data![index].main!.humidity!
                                                        .toStringAsFixed(1)
                                                        .toString() +
                                                    "%"),
                                            getWeatherInfoWidget(
                                                label: 'Хөрсний чийг',
                                                value:
                                                    snapshot.data![index].wind!.speed!.toStringAsFixed(1).toString() +
                                                        "%"),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            getWeatherInfoWidget(
                                                label: 'Хөрсний темпратур',
                                                value: (snapshot.data![index].main!.temp! - 273.15).toStringAsFixed(2) +
                                                    " °C"),
                                            getWeatherInfoWidget(
                                              label: 'Үүлний масс',
                                              value: (snapshot.data![index].clouds?.all ?? 0).toString() + ' %',
                                            ),
                                            getWeatherInfoWidget(
                                              label: 'Агаарын даралт',
                                              value: (snapshot.data![index].main!.pressure).toString() + " мм",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isLast ? Container() : Line5(),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: LoadingIndicatorWidget(),
              );
            }
          }),
    );
  }
}
