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
  // var isloaded = false;
  // @override
  // void initState() {
  //   super.initState();
  //   getdata();
  // }

  // getdata() async {
  //   posts = await RemoteService().getPosts();
  //   if (posts != null) {
  //     setState(() {
  //       isloaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 225, 225),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.Green,
        // leading: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //     )),
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
