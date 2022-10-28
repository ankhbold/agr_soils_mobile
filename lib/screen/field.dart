import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mvvm/res/components/field_sheet_button.dart';
import 'package:mvvm/res/components/round_sheet_button.dart';
import 'package:mvvm/res/components/season_sheet_button.dart';
import 'package:mvvm/screen/insight_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../res/components/panel_widget.dart';
import '../widget/floating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/geo/crs/crs.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:flutter_map/src/map/map.dart';
import 'package:latlong2/latlong.dart';

class FieldScreen extends StatefulWidget {
  const FieldScreen({Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  static double fabHeightClosed = 95.0;
  double fabHeight = fabHeightClosed;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    final panelHeightClosed = MediaQuery.of(context).size.height * 0.085;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SlidingUpPanel(
              backdropEnabled: true,
              maxHeight: panelHeightOpened,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (controller) => PanelWidget(
                controller: controller,
              ),
              onPanelSlide: (position) => setState(() {
                final panelMaxScrollExtent =
                    panelHeightOpened - panelHeightClosed;
                fabHeight =
                    position * panelMaxScrollExtent + panelHeightClosed + 20;
              }),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // image:
                    // DecorationImage(
                    //   image: AssetImage("assets/images/map2.jpg"),
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.035,
                        ),
                        Season(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        FieldsSheet(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        RoundSheetButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: fabHeight,
            child: buildFAB(context),
          ),
        ],
      ),
    );
  }
}

// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   actions: [
// InkWell(
//     onTap: () {
//       userPrefernece.remove().then((value) {
//         Navigator.pushNamed(context, RoutesName.login);
//       });
//     },
//     child: Center(child: Text('Гарах'))),
// SizedBox(
//   width: 20,
// )
//   ],
// ),

FlutterMap _buildMap() {
  // ignore: unnecessary_new
  return new FlutterMap(
    options: MapOptions(
      center: LatLng(50.093057, 105.715020),
      zoom: 9.2,
    ),
    nonRotatedChildren: [
      AttributionWidget.defaultWidget(
        source: 'OpenStreetMap contributors',
        onSourceTapped: null,
      ),
    ],
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      ),
    ],
  );
}
