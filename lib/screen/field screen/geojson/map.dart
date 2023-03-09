import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/screen/notes%20screen/search.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:mvvm/service/apis/get_notes_data.dart';
import 'package:http/http.dart' as http;
import '../../../constants/colors.dart';

class ScreenT extends StatefulWidget {
  const ScreenT({super.key});

  @override
  State<ScreenT> createState() => _ScreenTState();
}

class _ScreenTState extends State<ScreenT> {
  FetchUserList _userList = FetchUserList();

  var isloaded = false;

  @override
  void initState() {
    super.initState();
    FetchUserList();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data?[index].name}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Line3(),
                        ],
                      ),
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
