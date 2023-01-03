import 'package:flutter/material.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:geolocator/geolocator.dart';
import '../../service/apis/get_notes_data.dart';

import '../../service/remote_services.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final now = DateTime.now();

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // await Geolocator.openLocationSettings();
    print(position);
    print('-------------------------------');
  }

  // void getHTTP() async {
  //   try {
  //     var response = await Dio().get(
  //       'http://103.143.40.250:8100/api/note/type/getnotetype',
  //     );
  //     print(response);
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FinalNotesWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('-------------------------------');

          // getHTTP();
          print('-------------------------------');
          print(DateTime.now());
          print('-------------------------------');
          getLocation();
          print('-------------------------------');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FinalNotesWidget extends StatefulWidget {
  FinalNotesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FinalNotesWidget> createState() => _FinalNotesWidgetState();
}

class _FinalNotesWidgetState extends State<FinalNotesWidget> {
  List<GetNote> listNote = [];
  Repository repository = Repository();
  getGetNoteApi() async {
    listNote = await repository.getGetNoteApi();
    setState(() {});
  }

  @override
  void initState() {
    getGetNoteApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (BuildContext context, int index) {
          GetNote note = listNote[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Dismissible(
              key: Key(note.id.toString()),
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('delete?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                bool response =
                                    await repository.deleteData(note.id);
                                if (response) {
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pop(context, false);
                                }
                              },
                              child: const Text('yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('no')),
                        ],
                      );
                    });
              },
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
                            width: MediaQuery.of(context).size.width * 0.92,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${note.createdAt}',
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
                                      '${note.name}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromARGB(255, 127, 127, 127),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.edit))
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
                              )),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text('${note.nameEn}'),
                        ],
                      ),
                    ),
                  ),
                  const Line3(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
