import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../conf_global.dart';
import '../../constants/color.dart';
import '../../models/create_note_request.dart';
import '../../models/note.dart';
import '../../models/note_type.dart';
import '../../services/commons/exception.dart';
import '../../services/commons/img_upload.dart';
import '../../services/note_services.dart';
import '../../widget/cached_network_image.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/line.dart';
import '../../widget/loader.dart';
import '../../widget/outlined_btn.dart';
import '../../widget/snackbar.dart';
import '../field%20screen/field.dart';

class NoteAdd extends StatefulWidget {
  NoteAdd({super.key, this.success, this.isEdit = false, this.back});
  Function? success;
  Function? back;
  bool isEdit;

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

// class NoteImage {
//   String? image;
//    int? image;
// }

class _NoteAddState extends State<NoteAdd> {
  XFile? image;
  String? selectedType;
  int currentTypeIndex = -1;
  List<NoteType> noteTypes = [];
  List<String> images = [];
  final titleController = TextEditingController();
  DateTime currentDateTime = DateTime.now();
  DateTime chooseDateTime = DateTime.now();
  bool imageLoading = false;
  Note? currentNote;
  int? season_id;
  int index = 0;
  String? current_x, current_y;

  @override
  void initState() {
    super.initState();

    NoteService().getGetNoteType().then((value) {
      noteTypes = value;
      setState(() {});
    });
    // print('orsind');
  }

  Future pickImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image$e');
    } catch (Ex) {
      throw CustomException(errorMsg: Ex.toString());
    }
  }

  void changeToNote() {
    setState(() {
      isFabVisible = true;
      note = !note;
      isFirstWidgetVisible = true;
      isSecondWidgetVisible = false;
      isThirdWidgetVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(index);
    if (Globals.selectedNote != null) {
      index++;
    }
    if (Globals.selectedNote != null && index == 1) {
      // print('edit');
      currentNote = Globals.selectedNote!;
      images.clear();
      titleController.text = currentNote?.description ?? "";
      currentDateTime = DateTime.parse(currentNote!.created_at!);
      current_x = currentNote!.x_coordinate;
      current_y = currentNote!.y_coordinate;
      season_id = currentNote!.season_id;
      if (noteTypes.isNotEmpty) {
        currentTypeIndex = noteTypes.indexOf(noteTypes.singleWhere((element) => element.id == currentNote!.note_type));
        selectedType = noteTypes[currentTypeIndex].name;
        if (currentNote!.images != null) {
          images.addAll(currentNote!.images!);
        }
        setState(() {});
      }
      // Globals.changeSelectedNote(null);
    } else if (currentNote == null) {
      season_id = Globals.seasonId;
      current_x = Globals.longit;
      current_y = Globals.latit;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildNavigator(),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.back!();
                    },
                    child: Text(
                      'Буцах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Тэмдэглэл',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  TextButton(
                    onPressed: () async {
                      CreateNoteRequestModel createNoteRequestMode = CreateNoteRequestModel(
                        description: titleController.text,
                        season_id: season_id,
                        note_type: noteTypes[currentTypeIndex].id,
                        send_date: currentDateTime.toString(),
                        cordinate_x: currentNote == null
                            ? current_x
                            : (Globals.longit != currentNote!.x_coordinate
                                ? Globals.longit
                                : currentNote!.x_coordinate),
                        cordinate_y: currentNote == null
                            ? current_y
                            : (Globals.latit != currentNote!.y_coordinate ? Globals.latit : currentNote!.y_coordinate),
                        files: images,
                      );
                      LoadingIndicator(context: context).showLoadingIndicator();
                      if (currentNote == null) {
                        NoteService().createNoteStore(createNoteRequestMode).then((value) {
                          LoadingIndicator(context: context).hideLoadingIndicator();
                          setState(() {
                            isChoose = true;
                            isMarker = false;
                            isFabVisible = true;
                            note = false;
                            isFirstWidgetVisible = false;
                            isSecondWidgetVisible = false;
                            isThirdWidgetVisible = false;
                          });
                          Globals.changeSelectedNote(null);
                          widget.success!();
                        }).catchError((onError) {
                          LoadingIndicator(context: context).hideLoadingIndicator();
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                            message: onError,
                          ));
                          setState(() {
                            isChoose = true;
                            isMarker = false;
                            isFabVisible = true;
                            isFirstWidgetVisible = true;
                            isSecondWidgetVisible = false;
                            isThirdWidgetVisible = false;
                          });
                        });
                      } else {
                        NoteService()
                            .updateNote(
                          id: currentNote!.id,
                          createNoteRequestModel: createNoteRequestMode,
                        )
                            .then((value) {
                          LoadingIndicator(context: context).hideLoadingIndicator();
                          setState(() {
                            isChoose = true;
                            isMarker = false;
                            isFabVisible = true;
                            note = false;
                            isFirstWidgetVisible = false;
                            isSecondWidgetVisible = false;
                            isThirdWidgetVisible = false;
                          });
                          Globals.changeSelectedNote(null);
                          widget.success!();
                        }).catchError((onError) {
                          LoadingIndicator(context: context).hideLoadingIndicator();
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                            message: onError,
                          ));
                          setState(() {
                            isChoose = true;
                            isMarker = false;
                            isFabVisible = true;
                            isFirstWidgetVisible = true;
                            isSecondWidgetVisible = false;
                            isThirdWidgetVisible = false;
                          });
                        });
                      }
                    },
                    child: Text(
                      'Хадгалах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Line4(),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              // color: Colors.amber[500],
              child: CustomTextField(
                controller: titleController,
                textInputType: TextInputType.multiline,
                labelText: 'Таны тэмдэглэл...',
                context: context,
                onDone: () {},
              ),
            ),
          ),
          Line4(),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: InkWell(
              onTap: () {
                imageLoading = true;
                setState(() {});
                pickImage().then((value) {
                  ImgUploadService().sendImage(file: image)!.then((value) {
                    images.add(value!);
                    imageLoading = false;
                    setState(() {});
                  }).catchError((onError) {
                    imageLoading = false;
                    setState(() {});
                  });
                });
              },
              child: Ink(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.Green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Зураг оруулах',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          images.isNotEmpty
              ? Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: GridView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: images.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 10 / 7,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: MyCachedNetworkImage(
                                  imageUrl: images[index],
                                  fit: BoxFit.cover,
                                  isPlaceHolder: true,
                                  borderRadius: 10,
                                ),
                              ),
                            );
                          },
                        )),
                    imageLoading
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 80),
                              child: LoadingIndicatorWidget(
                                loaderColor: Color(0xff065F46),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              : imageLoading
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 80),
                        child: LoadingIndicatorWidget(
                          loaderColor: Color(0xff065F46),
                        ),
                      ),
                    )
                  : Container(),
          SizedBox(
            height: 20,
          ),
          Line4(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Төрөл',
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                alignment: AlignmentDirectional.topStart,
                hint: Text('Тэмдэглэлийн төрлөө сонгоно уу'),
                value: selectedType,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: noteTypes.map((item) {
                  return DropdownMenuItem(
                    value: item.name,
                    child: Text(item.name!),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    currentTypeIndex = noteTypes.indexOf(noteTypes.singleWhere((element) => element.name == newValue));
                    selectedType = newValue;
                  });
                },
              )
            ],
          ),
          Line5(),
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: CupertinoDatePicker(
                                  initialDateTime: chooseDateTime,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() => chooseDateTime = newDateTime);
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: CustomOutlinedBtn(
                                  text: 'Сонгох',
                                  onTap: () {
                                    Navigator.pop(context, chooseDateTime);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }).then((value) {
                if (value != null) {
                  setState(() {
                    currentDateTime = value;
                  });
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Он сар өдөр'),
                    Text(
                      currentDateTime.toString().split(".")[0],
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Line4(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    currentNote == null;
    setState(() {});
    super.dispose();
  }
}

Widget buildNavigator() => Container(
      padding: EdgeInsets.only(right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
