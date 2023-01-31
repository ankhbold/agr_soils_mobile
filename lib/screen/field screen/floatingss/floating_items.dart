import 'package:flutter/material.dart';
import 'package:mvvm/screen/field%20screen/floatingss/first_float.dart';

class FloatingFab extends StatefulWidget {
  const FloatingFab({super.key});

  @override
  State<FloatingFab> createState() => _FloatingFabState();
}

List<String> items = [
  "NDVI",
  "EVI",
  // "Хур тунадас",
  // "Таримлын төрөл",
  // "Ургацын дундаж",
  // "Тариалсан огноо",
  // "Хураасан огноо",
];
final List<Tab> myTabs = <Tab>[
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
                    color: Color.fromARGB(255, 0, 0, 0),
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

int current = 0;

class _FloatingFabState extends State<FloatingFab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.975,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.65),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 5,
                left: 5,
              ),
              child: SizedBox(child: myTabs[current]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
              width: MediaQuery.of(context).size.width * 0.925,
              child: ListView.builder(
                itemCount: 2,
                padding: const EdgeInsets.only(right: 3, left: 3),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    // width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 0.15),
                      color: current == index
                          ? const Color(0xff0f766e)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                      child: GestureDetector(
                        child: AnimatedContainer(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
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
          ],
        ),
      ),
    );
  }
}
