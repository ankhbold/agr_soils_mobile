import 'package:flutter/material.dart';
import 'package:mvvm/service/remote_services.dart';

import '../service/apis/get_notes_data.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
    return Scaffold(
      body: Visibility(
        visible: isloaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(posts![index].nameEn),
            );
          },
        ),
      ),
    );
  }
}
