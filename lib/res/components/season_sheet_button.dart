import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class Season extends StatelessWidget {
  const Season({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.33,
      height: MediaQuery.of(context).size.height * 0.035,
      child: FloatingActionButton.extended(
        heroTag: "btn1",
        backgroundColor: AppColors.Green.withOpacity(0.7),
        onPressed: () => showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Улирал сонгох',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cancel,
                            size: 35,
                            color: Color.fromARGB(255, 188, 188, 188),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.5,
                    color: const Color.fromARGB(115, 104, 104, 104),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Seasons(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Seasonss(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Seasonss(),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Улирал нэмэх',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 30,
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
          children: const [
            Text(
              'Улирал 2022',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 20,
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
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.check,
                color: AppColors.Green,
                size: 30,
              ),
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
            ),
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.Green,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
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
          children: const [
            SizedBox(
              width: 35,
            ),
            Text(
              'Арвин-Хур 2022 он',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 100,
            ),
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.Green,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 140),
          child: Text(
            'April 1 - Dec 31, 2022',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
