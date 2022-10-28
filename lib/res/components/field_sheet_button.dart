import 'package:flutter/material.dart';

class FieldsSheet extends StatelessWidget {
  const FieldsSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.045,
      child: FloatingActionButton.extended(
          heroTag: "btn2",
          backgroundColor: Colors.white.withOpacity(0.85),
          onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
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
                color: Colors.black,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.001,
              ),
              Text(
                'Талбай',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
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

class FieldSheet extends StatelessWidget {
  const FieldSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                      'Actions',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 500,
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.touch_app),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Select on map'),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 500,
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.draw_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Draw borders'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.27,
    );
  }
}
