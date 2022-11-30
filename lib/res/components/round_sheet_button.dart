import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field.dart';

bool status = false;
bool _value = true;

class RoundSheetButton extends StatefulWidget {
  const RoundSheetButton({
    Key? key,
  }) : super(key: key);

  @override
  State<RoundSheetButton> createState() => _RoundSheetButtonState();
}

class _RoundSheetButtonState extends State<RoundSheetButton> {
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
        backgroundColor: const Color(0xff0f766e).withOpacity(0.7),
        onPressed: () => showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Тохиргоо',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 40,
                              color: Color.fromARGB(
                                255,
                                188,
                                188,
                                188,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      const Text(
                        'Тэмдэглэл харуулах',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Switch.adaptive(
                          activeColor: AppColors.Green,
                          value: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = !_value;
                            });
                          }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      const Text(
                        'Бусдын талбарыг харуулах',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Switch.adaptive(
                          activeColor: AppColors.Green,
                          value: _value,
                          onChanged: (newValue) => (() => _value = newValue)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
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
