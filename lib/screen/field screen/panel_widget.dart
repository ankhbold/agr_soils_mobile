import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../constants/colors.dart';
import '../field%20screen/crop.dart';
import '../field%20screen/field.dart';

double lat = 49.939048;
double long = 105.841644;

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
            gradient: AppColors.grad,
          ),
          child: Column(
            children: <Widget>[
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
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(12)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Тариалсан',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '3 936 ha out of 3 936 ha',
                        style: TextStyle(
                            color: Color.fromARGB(255, 203, 203, 203), fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Crop(),
                        ),
                      );
                    },
                    child: Text(
                      'Ургац нэмэх',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 41, 41), fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    'Миний талбарууд',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                              TapMove(LatLng(49.939048, 105.841644));
                              isThirdWidgetVisible = true;
                              isAddFieldWidgetVisible = false;
                              // isFabVisible = false;
                              isFirstWidgetVisible = false;
                              isSecondWidgetVisible = false;
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '0 ha out of 0 ha',
                      style: TextStyle(color: Color.fromARGB(95, 255, 255, 255), fontSize: 13),
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
                  color: const Color.fromARGB(255, 219, 227, 231), borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ],
      ),
    );
  }
}

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
              width: MediaQuery.of(context).size.width * 0.2,
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


