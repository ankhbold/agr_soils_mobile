import 'package:flutter/material.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';
import 'package:mvvm/service/remote_services.dart';
import '../../service/apis/get_notes_data.dart';

class FinalNotesWidget extends StatefulWidget {
  const FinalNotesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FinalNotesWidget> createState() => _FinalNotesWidgetState();
}

class _FinalNotesWidgetState extends State<FinalNotesWidget> {
  Repository repository = Repository();
  List<GetNote> listNote = [];
  getGetNoteApi() async {
    listNote = await repository.getGetNoteApi();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    print(DateTime.now());
    getGetNoteApi();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (BuildContext context, int index) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${note.nameEn}',
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
                                  color: Color.fromARGB(255, 127, 127, 127),
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
                            )),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text(
                          '${note.nameEn}',
                        )
                      ],
                    ),
                  ),
                ),
                const Line3(),
              ],
            ),
          );
        },
      ),
    );
  }
}
