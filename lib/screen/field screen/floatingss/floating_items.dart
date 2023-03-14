import 'package:flutter/material.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/floatingss/first_float.dart';

class FloatingFab extends StatefulWidget {
  const FloatingFab({super.key});

  @override
  State<FloatingFab> createState() => _FloatingFabState();
}

List<String> items = [
  "NDVI",
  "EVI",
  "Хур тунадас",
  "Таримлын төрөл",
  "Ургацын дундаж",
  "Тариалсан огноо",
  "Хураасан огноо",
];
final List<Tab> myTabs = <Tab>[
  const Tab(
    child: FloatingItem(),
  ),
  const Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
];

class FloatingFourthItem extends StatefulWidget {
  FloatingFourthItem({
    Key? key,
  }) : super(key: key);

  @override
  State<FloatingFourthItem> createState() => _FloatingFourthItemState();
}

class _FloatingFourthItemState extends State<FloatingFourthItem> {
  List<String> item = [
    "Буудай",
    "Рапс",
    "Овъёос",
    "Арвай",
    "Тэжээлийн ургамал",
  ];

  List<Color> color = [
    Colors.red,
    Colors.blue,
    const Color.fromARGB(255, 226, 203, 0),
    Colors.green,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(60),
                    // border: Border.all(
                    //   width: 0,
                    // ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Text(
                  item[index],
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

bool sungahh = true;
int current = 0;

class _FloatingFabState extends State<FloatingFab> {
  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height * 0.125;
    final height2 = MediaQuery.of(context).size.height * 0.335;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: sungahh ? height1 : height2,
          width: MediaQuery.of(context).size.width * 0.98,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sungahh
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Байгалийн үндсэн өнгөний индекс',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ),
                            Text(
                              'Их',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100(),
                            Text(
                              'Дундаж',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100(),
                            Text(
                              'Эрэмбэлэгдсэн дундаж',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100(),
                            Text(
                              'Бага',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100(),
                            Text(
                              'Хазайлт',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100(),
                            Text(
                              'нягтралын',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Line100()
                          ],
                        ),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 5,
                  left: 5,
                ),
                child: SizedBox(child: myTabs[current]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: ListView.builder(
                      itemCount: 5,
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                          // width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.15),
                            color: current == index
                                ? const Color(0xff0f766e)
                                : Color.fromARGB(211, 255, 255, 255),
                          ),
                          child: Center(
                            child: GestureDetector(
                              child: AnimatedContainer(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                    color: current == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        sungahh = !sungahh;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.Green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.more_horiz,
                          size: 35,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Line100 extends StatelessWidget {
  const Line100({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: Color.fromARGB(156, 255, 255, 255),
        height: 1,
        width: MediaQuery.of(context).size.width * 0.95,
      ),
    );
  }
}
