import 'package:flutter/material.dart';

Widget buildFAB(BuildContext context) => AnimatedCrossFade(
      crossFadeState: CrossFadeState.showFirst,
      duration: Duration(milliseconds: 10),
      secondChild: SizedBox(),
      firstChild: Container(
        height: MediaQuery.of(context).size.width * 0.3,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Бага (Ургамал)',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            'Их',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff565656),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.193,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Үүл',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff565656),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(width: 8),
                Listview(),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );

class Listview extends StatelessWidget {
  const Listview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width * 0.915,
      child: ListView.builder(
        itemCount: 8,
        padding: EdgeInsets.all(3),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(3),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffB1B1B1),
            ),
            child: Center(
              child: Container(
                child: GestureDetector(
                  child: Text(
                    ' NDVI',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
