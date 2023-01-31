import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';

class FloatingItem extends StatelessWidget {
  const FloatingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 26,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Бага',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '(Ургамлын нормчлогдсон индекс)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 108, 100),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 65,
                  ),
                  Text(
                    'Их',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.Green,
                      Colors.green,
                      Colors.yellow,
                      Colors.orange,
                      Colors.red,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
