import 'package:flutter/material.dart';

class Season extends StatelessWidget {
  const Season({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.045,
      child: FloatingActionButton.extended(
          heroTag: "btn1",
          backgroundColor: Colors.white.withOpacity(0.85),
          onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 50, left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.27,
                );
              }),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Улирал 2022',
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
                color: Colors.black45,
              )
            ],
          )),
    );
//      Container(
//       height: 40,
//       width: MediaQuery.of(context).size.width * 0.3,
//       decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.9),
//           borderRadius: BorderRadius.circular(50)),
//       child: GestureDetector(
//         onTap: () =>
// showModalBottomSheet(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
//             context: context,
//             builder: (BuildContext context) {
//               return
// Container(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(right: 50, left: 50),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 5,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.27,
//               );
//             }),
//         child: Center(
//             child:
// Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 5,
//             ),
//             Text('Улирал 2022'),
//             Icon(
//               Icons.arrow_drop_down,
//               size: 18,
//               color: Colors.black45,
//             )
//           ],
//         )
// ),
//       ),
//     );
  }
}
