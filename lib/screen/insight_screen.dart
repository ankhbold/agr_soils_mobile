import 'package:flutter/material.dart';

// import '../data/listdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/geo/crs/crs.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:flutter_map/src/map/map.dart';
import 'package:latlong2/latlong.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScreenTwo();
  }
}

class _ScreenTwo extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.85,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Parcel list",
                  ),
                  background: _buildMap(),
                ),
              ),
            ];
          },
          body: Center(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search field",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //     TextField(
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Color(0Xff302360),
                      //     border:OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       borderSide: BorderSide.none,
                      //       ),
                      //       hintText: "Search field",
                      //       prefixIcon: Icon(Icons.search),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
        appBar: _buildAppBar(context),
      ),
    ));
  }
}

AppBar _buildAppBar(context) {
  return AppBar(
    actions: [
      // ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      //      shape: RoundedRectangleBorder(
      //      borderRadius: BorderRadius.circular(4.0)

      //           ),
      //       // style: ElevatedButton.styleFrom(
      //       //   shape: const StadiumBorder(),
      //       ),

      //       child: const Text('Pill '),
      //       onPressed: () {},
      //     ),

      Container(
        margin: EdgeInsets.only(
          top: 16,
          right: 16,
        ),
        child: Stack(
          children: <Widget>[
            new IconButton(
              icon: const Icon(
                Icons.arrow_downward_outlined,
              ),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.amber,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                child: Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      )
    ],
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}

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

// class ScreenTwo extends StatefulWidget {
//   const ScreenTwo({super.key});

//   @override
//   State<ScreenTwo> createState() => _ScreenTwoState();
// }

// class _ScreenTwoState extends State<ScreenTwo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.87,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Танд одоохондоо тэмдэглэл алга',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 19,
//                     fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 25,
//                   ),
//                   Text(
//                       'Газрын зураг дээр чухал газрыг тэмдэглэхийг\nхүссэн үедээ тэмдэглэл нэмнэ үү'),
//                 ],
//               ),
//               SizedBox(
//                 height: 35,
//               ),
//               Text(
//                 'Анхны тэмдэглэлээ нэмнэ үү',
//                 style: TextStyle(
//                     color: AppColors.Green,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Color(0xfff0f0f0),
//         title: Text(
//           'Тэмдэглэл',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }
