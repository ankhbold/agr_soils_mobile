import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/colors.dart';
import '../../models/unit_area.dart';
import '../../services/geo_service.dart';
import '../../widget/loader.dart';
import '../insight%20screen/weather.dart';
import '../insight%20screen/weather_screen.dart';
import '../sensor/sensor_chart.dart';
import '../unit_area/unit_areas.dart';
import '../widgets/button/default_button.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('M сарын d (H цаг)').format(now);
String formatDate = DateFormat('M сарын d').format(now);

class InsightScreen extends StatefulWidget {
  InsightScreen({super.key, this.tabController});
  PersistentTabController? tabController;
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
  double? latitude, longtitude;
  int currentIndex = 0;
  final ScrollController _firstController = ScrollController();
  List<UnitArea> areas = [];
  LatLng? latLng;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    GeoService.getGeoUnitArea().then((value) {
      areas = value;
      isLoading = false;
      latLng = LatLng(double.parse(value.first.coord_y!), double.parse(value.first.coord_x!));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0.5),
                  blurRadius: 0.1,
                ),
              ],
            ),
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
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: !isLoading
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _firstController,
                        itemCount: areas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                latLng =
                                    LatLng(double.parse(areas[index].coord_y!), double.parse(areas[index].coord_x!));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  gradient: currentIndex == index ? AppColors.grad : AppColors.gradi,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Ink(
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          areas[index].address_streetname ?? "",
                                          style: TextStyle(
                                            color: currentIndex == index ? Colors.white : Colors.black,
                                            fontSize: 13,
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
                      )
                    : LoadingIndicatorWidget(
                        loaderColor: Colors.green,
                      ),
              ),
              Weathers(
                latLng: latLng,
              ),
              DefaultButton(
                OnTap: () {
                  Navigator.pushNamed(context, 'page2');
                },
                text: 'Цаг агаарын урьдчилсан мэдээ',
              ),
              Container(
                height: 15,
                color: AppColors.grey,
              ),
              Chart(),
              DefaultButton(
                OnTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChartPage()));
                },
                text: 'Бүгдийг харах',
              ),
              Container(height: 15, color: AppColors.grey),
              AllUnitAreas(),
              DefaultButton(
                OnTap: () {
                  Navigator.pushNamed(context, 'page3');
                },
                text: 'Бүгдийг харах',
              ),
            ],
          ),
        ));
  }
}
