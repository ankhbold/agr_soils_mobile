import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class NoteScreen extends StatefulWidget {
  // PageController _pageController = PageController();
  NoteScreen({
    super.key,
  });

  @override
  State<NoteScreen> createState() => _ScreenState();
}

class _ScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
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
                NavigationBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.27,
                ),
                NotesNearby(),

                NotesProvince(),
                NotesLocation(),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Талбайн ургамлын индекс',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Index(),
              SizedBox(
                height: 20,
              ),
              roow(),
              SizedBox(
                height: 20,
              ),
              roow(),
              SizedBox(
                height: 20,
              ),
              roow(),
              SizedBox(
                height: 20,
              ),
              roow(),
              SizedBox(
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
          Container(
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
            children: [
              Text(
                'Талбай 3, 15 га',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Text(
                'Өргөст хэмх',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Column(
            children: [
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
        children: [
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
            color: Color(0xffb1b1b1),
          ),
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Бүх талбай')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Өргөст хэмх')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.29,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Буудай')),
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
          Text(
            'Байршилд хандахыг зөвшөөрөх',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
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
            color: Color(
              0xffb1b1b1,
            ),
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.015,
          ),
          Container(
            child: Center(
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
            color: Color(0xffb1b1b1),
          ),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Миний хажууд\nТалбай байхгүй')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Төв аймаг\n2 Талбай')),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffdadada),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Center(child: const Text('Байршил\nнэмэх')),
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
