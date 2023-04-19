import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/floatingss/first_float.dart';

class FloatingFields extends StatelessWidget {
  const FloatingFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.width * 0.03,
            ),
            child: FloatingItem(),
          )
        ],
      ),
    );
  }
}
