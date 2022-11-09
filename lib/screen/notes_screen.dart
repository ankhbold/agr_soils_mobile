import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/profile_screen.dart';

// import '../data/listdata.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> tabuud = [
      NotesWidget(
        dateText: 'Өчигдөр, 5:23 pm',
        onTap: () {},
        waterText: 'Усалгаатай',
        Note: 'талбай',
        typesText: 'Wheat soft, spring - 82.2ha',
        widget: Container(
          height: screenHeight * 0.16,
          width: screenWidth * 0.92,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
              'assets/images/note.jpeg',
            )),
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      NotesWidget(
        dateText: 'Өчигдөр, 5:23 pm',
        onTap: () {},
        waterText: 'Усалгаатай',
        Note: 'талбай',
        typesText: 'Wheat soft, spring - 82.2ha',
        widget: Container(
          height: screenHeight * 0.16,
          width: screenWidth * 0.92,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
              'assets/images/note.jpeg',
            )),
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      NotesWidget(
        dateText: 'Өчигдөр, 5:23 pm',
        onTap: () {},
        waterText: 'Усалгаатай',
        Note: 'талбай',
        typesText: 'Wheat soft, spring - 82.2ha',
        widget: Container(
          height: screenHeight * 0.16,
          width: screenWidth * 0.92,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
              'assets/images/note.jpeg',
            )),
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      NotesWidget(
        dateText: 'Өчигдөр, 5:23 pm',
        onTap: () {},
        waterText: 'Усалгаатай',
        Note: 'талбай',
        typesText: 'Wheat soft, spring - 82.2ha',
        widget: Container(
          height: screenHeight * 0.16,
          width: screenWidth * 0.92,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
              'assets/images/note.jpeg',
            )),
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ];

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          backgroundColor: AppColors.Green,
          title: Column(
            children: [
              const Text(
                'Тэмдэглэл',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const BuildTextField(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
            ],
          ),
          toolbarHeight: screenHeight * 0.12,
        ),
        body: SizedBox(
          height: screenHeight * 0.738,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: tabuud.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: tabuud[index],
              );
            },
          ),
        ));
  }
}

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
    required this.dateText,
    required this.waterText,
    required this.typesText,
    required this.onTap,
    required this.widget,
    required this.Note,
  });
  final String dateText;
  final String waterText;
  final String typesText;
  final String Note;
  final VoidCallback onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.3,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: screenWidth * 0.92,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          waterText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          typesText,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 81, 81, 81)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              widget,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Note,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Line3(),
      ],
    );
  }
}

class BuildTextField extends StatefulWidget {
  const BuildTextField({super.key});

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 219, 219),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.only(),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: AppColors.Green,
                  ),
                  border: InputBorder.none,
                  hintText: 'Хайлтын утгаа оруулна уу',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
