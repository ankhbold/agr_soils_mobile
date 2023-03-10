import 'package:flutter/material.dart';
import 'package:mvvm/screen/notes%20screen/notes_screen.dart';
import 'package:mvvm/screen/notes%20screen/search.dart';
import 'package:mvvm/service/remote_services.dart';

import '../../constants/color.dart';
import '../../service/apis/get_notes_data.dart';
import '../profile screen/profile_screen.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  FetchUserList _userList = FetchUserList();
  Repository repository = Repository();

  List<GetNote> listNote = [];
  getGetNoteApi() async {
    listNote = await repository.getGetNoteApi();
    setState(() {
      isloaded = true;
    });
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
        // automaticallyImplyLeading: false,
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
                  GetNote note = listNote[index];
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
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() async {
                                              _userList
                                                  .deleteData(note.id as int);
                                            });
                                          },
                                          child: null)
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
