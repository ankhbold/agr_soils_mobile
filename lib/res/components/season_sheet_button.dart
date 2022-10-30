import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class Season extends StatelessWidget {
  const Season({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.04,
      child: FloatingActionButton.extended(
        heroTag: "btn1",
        backgroundColor: AppColors.Green.withOpacity(0.7),
        onPressed: () => showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Улирал сонгох',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.cancel,
                            size: 40,
                            color: Color.fromARGB(255, 188, 188, 188),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.5,
                    color: Color.fromARGB(115, 104, 104, 104),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Seasons(),
                  SizedBox(
                    height: 20,
                  ),
                  Seasonss(),
                  SizedBox(
                    height: 20,
                  ),
                  Seasonss(),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add season',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Улирал 2022',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: Color.fromARGB(255, 255, 255, 255),
            )
          ],
        ),
      ),
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

class Seasons extends StatelessWidget {
  const Seasons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.check,
              color: AppColors.Green,
              size: 35,
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
            ),
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.Green,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class Seasonss extends StatelessWidget {
  const Seasonss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 35,
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
            ),
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.Green,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
