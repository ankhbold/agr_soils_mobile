import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/field.dart';

import 'package:mvvm/screen/field%20screen/floating_fields.dart';
import 'package:mvvm/screen/field%20screen/ndvi_sheet_button.dart';

class FieldsSheet extends StatefulWidget {
  final Function notecreate;
  final Function polygoncreate;

  const FieldsSheet(
      {super.key, required this.notecreate, required this.polygoncreate});

  @override
  State<FieldsSheet> createState() => _FieldsSheetState();
}

class _FieldsSheetState extends State<FieldsSheet> {
  // late List<dynamic> _geojson;
  void _getGeoJson() async {
    // NetworkHelper networkHelper = NetworkHelper(url: uri);
    // var geoJson = await networkHelper.getGeo();
  }

  @override
  void initState() {
    super.initState();
    _getGeoJson();
  }

  late final List<dynamic> seasons;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Color.fromARGB(36, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
          // heroTag: Text("btn2"),
          // color: Color.fromARGB(255, 255, 255, 255),
          onTap: () {
            // print(_geojson);
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.27,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 50, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Үйлдлүүд',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 40,
                                width: 500,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.notecreate();
                                      // ChangeStage();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.touch_app,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Тэмдэглэл нэмэх'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 40,
                                width: 500,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.polygoncreate();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Ink(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.draw_rounded,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Талбай зурах'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          )),
    );
  }
}

class SecondFab extends StatefulWidget {
  const SecondFab({super.key});

  @override
  State<SecondFab> createState() => _SecondFabState();
}

class _SecondFabState extends State<SecondFab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.22,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 239, 239)
                          .withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: click ? 2 : 0, color: AppColors.Green)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        clicks = !clicks;
                        clicked = index;
                      });
                    },
                    child: Ink(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tabs[index],
                            Text(
                              'Nov 23',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        NdviButton(),
      ],
    );
  }
}
//     Container(
//       height: 40,
//       width: MediaQuery.of(context).size.width * 0.25,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: GestureDetector(
//         onTap: ()
// => showModalBottomSheet(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
//             context: context,
//             builder: (BuildContext context) {
//               return FieldSheet();
//             }),
//         child: Center(
//             child:
// Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.add,
//               size: 25,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.001,
//             ),
//             Text('Талбай'),
//           ],
//         )
// ),
//       ),
//     );
//   }
// }

