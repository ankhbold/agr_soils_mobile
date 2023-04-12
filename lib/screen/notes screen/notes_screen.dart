import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/widget/cached_network_image.dart';
import '../../models/note.dart';
import '../../services/commons/apis.dart';
import '../../services/remote_services.dart';
import '../../constants/colors.dart';
import '../../widget/loader.dart';
import '../../widget/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

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
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
