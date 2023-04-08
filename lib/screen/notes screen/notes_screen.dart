import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';
import '../../service/apis/get_notes_data.dart';
import '../../widget/loader.dart';
import '../../widget/snackbar.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  bool isLoading = true;

  FetchUserList _userList = FetchUserList();
  // Repository repository = Repository();
  List<GetNote> listNote = [], currentListNote = [];
  getGetNoteApi() async {
    listNote = await _userList.getNoteList();
    currentListNote = listNote;
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getGetNoteApi();
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
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    CupertinoSearchTextField(
                      placeholder: "Тэмдэглэл хайх",
                      onChanged: (String value) {
                        currentListNote = currentListNote.where((element) => element.name!.contains(value)).toList();

                        if (value == '') {
                          currentListNote = listNote;
                        }
                        setState(() {});
                        // print(value);
                        // fieldValue('The text has changed to: $value');
                      },
                      onSubmitted: (String value) {
                        currentListNote = currentListNote.where((element) => element.name!.contains(value)).toList();
                        if (value == '') {
                          currentListNote = listNote;
                        }
                        setState(() {});
                        // fieldValue('Submitted text: $value');
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: currentListNote.length,
                            itemBuilder: (context, index) {
                              GetNote note = currentListNote[index];
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.92,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          currentListNote[index].createdAt!,
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          currentListNote[index].name!,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   '${data[index].}',
                                                        //   style: const TextStyle(
                                                        //     fontSize: 14,
                                                        //     fontWeight: FontWeight.w400,
                                                        //     color: Color.fromARGB(
                                                        //         255, 127, 127, 127),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        LoadingIndicator(context: context).showLoadingIndicator();
                                                        _userList.deleteNote(note.id as int).then(
                                                          (value) {
                                                            LoadingIndicator(context: context).hideLoadingIndicator();
                                                            ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                                                              message: "Амжилттай устгалаа",
                                                            ));
                                                            setState(() {
                                                              currentListNote.removeAt(index);
                                                            });
                                                          },
                                                        ).catchError((onError) {
                                                          LoadingIndicator(context: context).hideLoadingIndicator();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 50,
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          // color: Color.fromARGB(
                                                          //     255, 185, 52, 43),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.16,
                                                width: MediaQuery.of(context).size.width * 0.92,
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
                                                '${currentListNote[index].description ?? ""}',
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
                  ],
                )),
    );
  }
}

class FetchUserList {
  var data = [];
  List<GetNote> results = [];
  String urlList = 'http://103.143.40.250:8100/api/note/type/getnotetype';

  Future<List<GetNote>> getNoteList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => GetNote.fromJson(e)).toList();
        if (query != null) {
          results = results.where((element) => element.name!.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  String uri5 = 'http://103.143.40.250:8100/api/note/delete';
  Future deleteNote(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$uri5/$id'),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> refreshList() async {
    results = await getNoteList();
  }
}
