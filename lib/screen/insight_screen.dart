import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class InsightScreen extends StatefulWidget {
  // PageController _pageController = PageController();
  const InsightScreen({
    super.key,
  });

  @override
  State<InsightScreen> createState() => _ScreenState();
}

class _ScreenState extends State<InsightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: ListView(
        children: [
          // DefaultTabController(
          //   length: 3,
          //   child: TabBarView(
          //     children: [
          //       NavigationBar(),
          //     ],
          //   ),
          // ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.width * 0.817,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                const NavigationBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.27,
                ),
                const NotesNearby(),

                const NotesProvince(),
                const NotesLocation(),
                // NavigationBar(),
                // BuildPageView(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Талбайн ургамлын индекс',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Index(),
              const SizedBox(
                height: 20,
              ),
              const roow(),
              const SizedBox(
                height: 20,
              ),
              const roow(),
              const SizedBox(
                height: 20,
              ),
              const roow(),
              const SizedBox(
                height: 20,
              ),
              const roow(),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class roow extends StatelessWidget {
  const roow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Талбай 3, 15 га',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Text(
                'Буудай',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Column(
            children: const [
              Text(
                'Sep 11',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              Text(
                '0,29',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Index extends StatelessWidget {
  const Index({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          NavigationBarr(),
        ],
      ),
    );
  }
}

class NavigationBarr extends StatelessWidget {
  const NavigationBarr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffb1b1b1),
          ),
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Бүх талбай')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Буудай')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Буудай')),
          ),
        ),
      ],
    );
  }
}

class NotesNearby extends StatelessWidget {
  const NotesNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Байршилд хандахыг зөвшөөрөх',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          const Text(
            'Тохиргоог нээх',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.Green),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.15,
          ),
          Container(
            color: const Color(
              0xffb1b1b1,
            ),
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.015,
          ),
          Container(
            child: const Center(
              child: Text(
                'Өргөтгөсөн урьдчилсан мэдээ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotesProvince extends StatelessWidget {
  const NotesProvince({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 54, 244, 101),
    );
  }
}

class NotesLocation extends StatelessWidget {
  const NotesLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 98, 54, 244),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffb1b1b1),
          ),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Миний хажууд\nТалбай байхгүй')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Төв аймаг\n2 Талбай')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Center(child: Text('Байршил\nнэмэх')),
          ),
        ),
      ],
    );
  }
}

// class BuildPageView extends StatelessWidget {
//   const BuildPageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: PageView(
//         controller: _pageController,
//         children: const [
//           NotesLocation(),
//           NotesNearby(),
//           NotesProvince(),
//         ],
//       ),
//     );
//   }
// }

class BuildPageView extends StatelessWidget {
  const BuildPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: PageView(
        children: const [
          NotesNearby(),
          NotesProvince(),
          NotesLocation(),
        ],
      ),
    );
  }
}
