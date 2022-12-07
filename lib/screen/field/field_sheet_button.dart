import 'package:flutter/material.dart';
import 'package:mvvm/screen/field/field.dart';

class FieldsSheet extends StatelessWidget {
  const FieldsSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.04,
      child: FloatingActionButton.extended(
          heroTag: Text("btn2"),
          backgroundColor: Color(0xff0f766e).withOpacity(0.8),
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
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.001,
              ),
              Text(
                'Талбай',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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

