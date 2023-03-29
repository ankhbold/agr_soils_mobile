import 'package:flutter/material.dart';

class FloatingItem extends StatelessWidget {
  const FloatingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Бага',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' (Ургамлын нормчлогдсон индекс)',
                            style: TextStyle(
                              color: Color.fromARGB(255, 154, 197, 194),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Их',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ColorIndex()
            ],
          ),
        ),
      ],
    );
  }
}

class ColorIndex extends StatelessWidget {
  const ColorIndex({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.008,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Color.fromARGB(255, 94, 18, 12),
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     AppColors.Green,
                //     Colors.green,
                //     Colors.yellow,
                //     Colors.orange,
                //     Colors.red,
                //   ],
                // ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 135, 24, 24),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 167, 32, 32),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow[800],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow[700],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow[600],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow[400],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 224, 240, 79),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[200],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[300],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[400],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[500],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[600],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[700],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[800],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     AppColors.Green,
                //     Colors.green,
                //     Colors.yellow,
                //     Colors.orange,
                //     Colors.red,
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     AppColors.Green,
        //     Colors.green,
        //     Colors.yellow,
        //     Colors.orange,
        //     Colors.red,
        //   ],
        // ),
      ),
    );
  }
}
