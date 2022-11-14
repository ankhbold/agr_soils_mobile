import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';
import 'package:mvvm/screen/test_screen.dart';

import '../service/apis/get_notes_data.dart';
import '../service/remote_services.dart';

// import '../data/listdata.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<Post>? posts;
  var isloaded = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 225, 225),
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
      body: FinalNotesWidget(isloaded: isloaded, posts: posts),
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
