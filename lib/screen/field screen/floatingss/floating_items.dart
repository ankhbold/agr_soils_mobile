import 'package:flutter/material.dart';
import 'package:mvvm/models/raster_layer.dart';
import 'package:mvvm/services/geo_service.dart';
import 'package:mvvm/widget/snackbar.dart';

import '../../../constants/color.dart';
import '../../field%20screen/floatingss/first_float.dart';

class FloatingFab extends StatefulWidget {
  FloatingFab({super.key, this.changeLayer});
  Function(RasterLayer layer)? changeLayer;

  @override
  State<FloatingFab> createState() => _FloatingFabState();
}

bool sungahh = true;
int current = 0;

class _FloatingFabState extends State<FloatingFab> {
  List<RasterLayer> layers = [];
  @override
  void initState() {
    super.initState();
    GeoService.getRasterLayer().then((value) {
      layers = value;
      setState(() {});
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
        message: onError.toString(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height * 0.13;
    final height2 = MediaQuery.of(context).size.height * 0.42;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: sungahh ? height1 : height2,
        width: MediaQuery.of(context).size.width * 0.98,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                child: FloatingItem(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.98,
                    child: ListView.builder(
                      itemCount: layers.length,
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                            widget.changeLayer!(layers[index]);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.01,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.15),
                              color: current == index ? const Color(0xff0f766e) : Color.fromARGB(211, 255, 255, 255),
                            ),
                            child: Center(
                              child: AnimatedContainer(
                                margin: const EdgeInsets.symmetric(horizontal: 12),
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  layers[index].name!,
                                  style: TextStyle(
                                    color: current == index ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SateliteDetailInfo extends StatelessWidget {
  const SateliteDetailInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Байгалийн үндсэн өнгөний индекс',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
        Text(
          'Их',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100(),
        Text(
          'Дундаж',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100(),
        Text(
          'Эрэмбэлэгдсэн дундаж',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100(),
        Text(
          'Бага',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100(),
        Text(
          'Хазайлт',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100(),
        Text(
          'нягтралын',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        Line100()
      ],
    );
  }
}

class Line100 extends StatelessWidget {
  const Line100({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: Color.fromARGB(156, 255, 255, 255),
        height: 1,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }
}
