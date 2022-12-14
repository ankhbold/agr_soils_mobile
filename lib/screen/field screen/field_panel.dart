import 'package:flutter/material.dart';
import 'package:mvvm/screen/insight%20screen/insight_screen.dart';

import '../../constants/color.dart';
import 'field.dart';
import '../profile screen/profile_screen.dart';

class FieldPanel extends StatelessWidget {
  final ScrollController controller;

  const FieldPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 239, 253, 248),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          controller: controller,
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.21,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Container(
                      child: Container(
                          padding: const EdgeInsets.only(right: 50, left: 50),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ]))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '?????????? ???????????? 3????',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              'add crop',
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.Green),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      GestureDetector(
                        child: const RemoveButton(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Line3(),
            const SizedBox(
              height: 10,
            ),
            Weather(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}

// class RemoveButton extends StatefulWidget {
//   const RemoveButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<RemoveButton> createState() => _RemoveButtonState();
// }

// class _RemoveButtonState extends State<RemoveButton> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         Icons.remove_circle,
//         color: Colors.black.withOpacity(0.5),
//         size: 30,
//       ),
//       onPressed: () {
//         setState(() {
//           click = !click;
//           fclick = !fclick;
//           isFirstWidgetVisible = true;
//           isSecondWidgetVisible = false;
//           isThirdWidgetVisible = false;
//         });
//       },
//     );
//   }
// }
class RemoveButton extends StatelessWidget {
  const RemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.remove_circle,
        color: Colors.black.withOpacity(0.5),
        size: 30,
      ),
      onPressed: () {
        click = !click;
        fclick = !fclick;
        isFirstWidgetVisible = true;
        isSecondWidgetVisible = false;
        isThirdWidgetVisible = false;
      },
    );
  }
}
