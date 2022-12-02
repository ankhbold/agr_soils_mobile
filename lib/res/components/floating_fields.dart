import 'package:flutter/material.dart';

import '../../constants/color.dart';

class FloatingFields extends StatefulWidget {
  const FloatingFields({super.key});

  @override
  State<FloatingFields> createState() => _FloatingFieldsState();
}

final List<Tab> Tabss = <Tab>[
  const Tab(
    child: FloatingFields(),
  ),
  const Tab(
    child: FloatingItem(),
  ),
];

final List<Tab> Tabs = <Tab>[
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
  const Tab(
    child: Rectangular(),
  ),
];
final List<Tab> myTabs = <Tab>[
  const Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  const Tab(
    child: FloatingSecondItem(),
  ),
  const Tab(
    child: FloatingThirdItem(),
  ),
  const Tab(
    child: FloatingItem(),
  ),
  Tab(
    child: FloatingFourthItem(),
  ),
  const Tab(
    child: FloatingSecondItem(),
  ),
  const Tab(
    child: FloatingThirdItem(),
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
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
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
        );
      },
    );
  }
}

class FloatingSecondItem extends StatelessWidget {
  const FloatingSecondItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.Green,
                              Colors.green,
                              Color.fromARGB(255, 89, 255, 95),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FloatingThirdItem extends StatelessWidget {
  const FloatingThirdItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 255, 190, 69),
                              Color.fromARGB(255, 255, 122, 69),
                              Color.fromARGB(255, 255, 94, 0),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FloatingItem extends StatelessWidget {
  const FloatingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.Green,
                              Colors.green,
                              Colors.yellow,
                              Colors.orange,
                              Colors.red,
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Үүлтэй',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(129, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

int current = 0;

class _FloatingFieldsState extends State<FloatingFields> {
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
              child: myTabs[current]),

          // SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    );
  }
}

class Rectangular extends StatelessWidget {
  const Rectangular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45,
            child: Image.asset(
              'assets/images/ones.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
