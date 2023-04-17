import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mvvm/conf_global.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/colors.dart';
import '../../models/note.dart';
import '../../services/commons/apis.dart';
import '../../services/note_services.dart';
import '../../widget/cached_network_image.dart';
import '../../widget/loader.dart';
import '../../widget/snackbar.dart';
import '../field screen/field.dart';

// ignore: must_be_immutable
class NoteListPage extends StatefulWidget {
  NoteListPage({super.key, this.tabController, this.changeLocation});
  PersistentTabController? tabController;
  Function? changeLocation;
  @override
  State<NoteListPage> createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  bool isLoading = true;

  List<Note> listNote = [], currentListNote = [];
  getGetNoteApi() async {
    listNote = await NoteService().getNoteList();
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
                      currentListNote = currentListNote
                          .where((element) => element.note_type_desc!.toLowerCase().contains(value.toLowerCase()))
                          .toList();

                      if (value == '') {
                        currentListNote = listNote;
                      }
                      setState(() {});
                    },
                    onSubmitted: (String value) {
                      currentListNote = currentListNote
                          .where((element) => element.note_type_desc!.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                      if (value == '') {
                        currentListNote = listNote;
                      }
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: currentListNote.length,
                        itemBuilder: (context, index) {
                          Note note = currentListNote[index];
                          return InkWell(
                            onTap: () {
                              widget.changeLocation!();
                              NoteMove(
                                LatLng(
                                  double.parse(note.y_coordinate!),
                                  double.parse(note.x_coordinate!),
                                ),
                              );
                              widget.tabController!.jumpToTab(0);
                            },
                            child: Container(
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
                                                        currentListNote[index].created_at!,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        currentListNote[index].note_type_desc!,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      LoadingIndicator(context: context).showLoadingIndicator();
                                                      NoteService().deleteNote(note.id as int).then(
                                                        (value) {
                                                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                                                            message: "Амжилттай устгалаа",
                                                          ));

                                                          setState(() {
                                                            currentListNote.removeAt(index);
                                                          });
                                                          LoadingIndicator(context: context).hideLoadingIndicator();
                                                        },
                                                      ).catchError((onError) {
                                                        LoadingIndicator(context: context).hideLoadingIndicator();
                                                      });
                                                    },
                                                    child: Image.asset(
                                                      "assets/common/remove.png",
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.16,
                                              width: MediaQuery.of(context).size.width * 0.92,
                                              child: MyCachedNetworkImage(
                                                fit: BoxFit.contain,
                                                isPlaceHolder: true,
                                                imageUrl: main_host_url.toString() +
                                                    "/" +
                                                    currentListNote[index].image_url.toString(),
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
                            ),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
