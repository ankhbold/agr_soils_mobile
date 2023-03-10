import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/screen/notes%20screen/search.dart';

import '../../service/apis/get_notes_data.dart';
import '../../service/remote_services.dart';
import '../profile screen/profile_screen.dart';

// import '../data/listdata.dart';

void getWMSResponse() async {
  var url =
      'http://103.143.40.250:8080/geoserver/agrgis/wms?service=WMS&version=1.1.0&request=GetMap&layers=agrgis%3Aagr_parcel&bbox=104.83374631177468%2C48.61366916210431%2C106.18761342734588%2C50.393568299264835&width=584&height=768&srs=EPSG%3A4326&styles=&format=application/openlayers';
  var response = await http.get(Uri.parse(url));

  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  bool isLoading = false;
  FetchUserList _userList = FetchUserList();
  Repository repository = Repository();
  List<GetNote> listNote = [];
  getGetNoteApi() async {
    listNote = await repository.getGetNoteApi();
    isloaded = true;
  }

  var isloaded = false;

  @override
  void initState() {
    getWMSResponse();
    super.initState();
    FetchUserList();

    // print(DateTime.now());
    getGetNoteApi();
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
            return isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      GetNote note = listNote[index];

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.92,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
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
                                          InkWell(
                                            onTap: () async {
                                              _userList
                                                  .deleteData(note.id as int);
                                              setState(() {
                                                listNote.removeAt(index);
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.16,
                                      width: MediaQuery.of(context).size.width *
                                          0.92,
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

  String uri5 = 'http://103.143.40.250:8100/api/note/delete';
  Future deleteData(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$uri5/$id'),
      );
      if (response.statusCode == 200) {
        SnackBar(content: Text('Тэмдэглэл устлаа.'));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> refreshList() async {
    results = await getuserList();
  }
}
