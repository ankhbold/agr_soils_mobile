import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/field%20screen/field.dart';
import 'add_note.dart';

double long = 49.939048;
double lat = 105.841644;

class PanelWidget extends StatefulWidget {
  final ScrollController controller;

  const PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  void pop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            // color: AppColors.whiteColor,
            gradient: AppColors.grad,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(15),
            //   bottomRight: Radius.circular(15),
            // ),
          ),
          child: Column(
            children: <Widget>[
              // CustomNavigator(),
              // Padding(
              //   padding: EdgeInsets.only(right: 50, left: 50),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 5,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(25),
              //           color: const Color.fromARGB(255, 255, 255, 255),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pop();
                          TapMove(LatLng(lat, long));
                          isAddFieldWidgetVisible = false;
                          // isFabVisible = false;
                          isFirstWidgetVisible = false;
                          isSecondWidgetVisible = false;
                          isThirdWidgetVisible = true;
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                    ),
                    Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: AppColors.Green,
                          ),
                          border: InputBorder.none,
                          hintText: 'Талбай хайна уу',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Planted(),
              // const SizedBox(
              //   height: 10,
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              pop();
                              TapMove(LatLng(49.939048, 105.841644));
                              isAddFieldWidgetVisible = false;
                              // isFabVisible = false;
                              isFirstWidgetVisible = false;
                              isSecondWidgetVisible = false;
                              isThirdWidgetVisible = true;
                            });
                          },
                          child: Roow()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

// class CustomNavigator extends StatelessWidget {
//   const CustomNavigator({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.015,
//     );
//   }
// }

class Planted extends StatelessWidget {
  const Planted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 7,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Тариалан',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '0 ha out of 0 ha',
                      style: TextStyle(
                          color: Color.fromARGB(95, 255, 255, 255),
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Газар тариалан үүсгэх',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B7B7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
          Container(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.94,
              height: 20,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 227, 231),
                  borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ],
      ),
    );
  }
}

// class TextFieldField extends StatefulWidget {
//   const TextFieldField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TextFieldField> createState() => _TextFieldFieldState();
// }

// class _TextFieldFieldState extends State<TextFieldField> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Padding(
//         padding: EdgeInsets.only(right: 10, left: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(

//               child: Container(
//                 height: 40,
//                 width: 280,
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 255, 255, 255),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: EdgeInsets.only(),

//                     child: TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.search,
//                           size: 20,
//                           color: AppColors.Green,
//                         ),
//                         border: InputBorder.none,
//                         hintText: 'Талбай хайна уу',
//                       ),
//                     ),

//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Roow extends StatelessWidget {
  const Roow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click = !click;
        fclick = !fclick;
        isFirstWidgetVisible = false;
        isSecondWidgetVisible = false;
        isThirdWidgetVisible = true;
      },
      child: Ink(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.18,
              child: Image.asset(
                'assets/images/ones.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Тэлэх талбай 15 га',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Буудай',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
            Column(
              children: [
                const Text(
                  '0.14',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      '-0.01',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PanelWidget2 extends StatelessWidget {
  final ScrollController controller;

  PanelWidget2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ListView(controller: controller, padding: EdgeInsets.zero, children: [
        NoteAdd(),
      ]);
}
