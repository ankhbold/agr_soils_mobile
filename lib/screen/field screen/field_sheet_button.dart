import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/field.dart';

import 'package:mvvm/screen/field%20screen/floating_fields.dart';
import 'package:mvvm/screen/field%20screen/ndvi_sheet_button.dart';

class FieldsSheet extends StatelessWidget {
  const FieldsSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.04,
      child: FloatingActionButton.extended(
        heroTag: Text("btn2"),
        backgroundColor: Color(0xff0f766e).withOpacity(0.8),
        onPressed: () => showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            context: context,
            builder: (BuildContext context) {
              return FieldSheet();
            }),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 25,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
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

