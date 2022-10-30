import 'package:flutter/material.dart';

import '../../constants/color.dart';

class RoundSheetButton extends StatelessWidget {
  const RoundSheetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.7),
      ),
      child: FloatingActionButton.extended(
        heroTag: "btn3",
        backgroundColor: Color(0xff0f766e).withOpacity(0.7),
        onPressed: () => showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
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
                        'Тохиргоо',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 220,
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
                ],
              ),
            );
          },
        ),
        label: Image.asset(
          'assets/images/image.png',
          color: Colors.white,
        ),
      ),
    );
  }
}
