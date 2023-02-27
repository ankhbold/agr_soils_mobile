import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/screen/notes%20screen/search.dart';

import '../../service/apis/get_notes_data.dart';
import '../profile screen/profile_screen.dart';

// import '../data/listdata.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  FetchUserList _userList = FetchUserList();
  // List<GetNote> listNote = [];
  // getGetNoteApi() async {
  //   listNote = await repository.getGetNoteApi();
  //   setState(() {
  //     isloaded = true;
  //   });
  // }

  var isloaded = false;

  @override
  void initState() {
    super.initState();
    FetchUserList();
    print(DateTime.now());
    // getGetNoteApi();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 225, 225),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.Green,
        title: const Text(
          'Тэмдэглэл',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search, size: 30),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<GetNote>>(
          future: _userList.getuserList(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data?[index].name}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Text(
                                        'усалгаатай - 1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '${data?[index].createdAt}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 127, 127, 127),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/note.jpeg',
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Text(
                                  '${data?[index].description}',
                                )
                              ],
                            ),
                          ),
                        ),
                        const Line3(),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}

class FetchUserList {
  var data = [];
  List<GetNote> results = [];
  String urlList = 'http://103.143.40.250:8100/api/note/type/getnotetype';

  Future<List<GetNote>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => GetNote.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.name!.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
