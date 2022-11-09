import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.Green,
          title: Column(
            children: [
              const Text(
                'Тэмдэглэл',
                style: TextStyle(fontSize: 15),
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
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.65,
              width: screenWidth,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tabuud.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: tabuud[index],
                  );
                },
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.085,
              color: AppColors.Green,
            )
          ],
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
    return Container(
      height: screenWidth * 0.65,
      width: screenWidth,
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
                GestureDetector(
                  onTap: () {
                    onTap;
                  },
                  child: const Icon(Icons.download),
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
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.only(),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 30,
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
