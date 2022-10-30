import 'package:flutter/material.dart';

// import '../data/listdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/geo/crs/crs.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:flutter_map/src/map/map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/color.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Танд одоохондоо тэмдэглэл алга',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                      'Газрын зураг дээр чухал газрыг тэмдэглэхийг\nхүссэн үедээ тэмдэглэл нэмнэ үү'),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Анхны тэмдэглэлээ нэмнэ үү',
                style: TextStyle(
                    color: AppColors.Green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xfff0f0f0),
        title: Text(
          'Тэмдэглэл',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
