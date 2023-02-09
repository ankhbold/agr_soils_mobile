import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:mvvm/screen/notes%20screen/test_screen.dart';

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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 225, 225),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: AppColors.Green,
          flexibleSpace: Container(
            // height: 200,
            decoration: const BoxDecoration(
              gradient: AppColors.grad,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Тэмдэглэл',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                // SizedBox(
                //   height: screenHeight * 0.02,
                // ),
                // Container(
                //   decoration: BoxDecoration(color: Colors.white),
                //   height: 30,
                //   width: 400,
                // ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const BuildTextField(),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            ),
          ),
          // title:
          // toolbarHeight: screenHeight * 0.12,
        ),
      ),
      body: FinalNotesWidget(),
    );
  }
}

class BuildTextField extends StatefulWidget {
  const BuildTextField({super.key});

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  void updateList(String value) {}
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
              color: const Color.fromARGB(255, 242, 242, 242),
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
