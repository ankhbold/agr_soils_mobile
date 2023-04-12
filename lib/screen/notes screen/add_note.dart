import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm/conf_global.dart';
import 'package:mvvm/models/note_type.dart';

import '../../constants/color.dart';
import '../../services/remote_services.dart';
import '../../widget/loader.dart';
import '../../widget/outlined_btn.dart';
import '../../widget/snackbar.dart';
import '../field%20screen/field.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  List<String> types = ['Disease', 'Pests', 'Weeds', 'Lodging', 'Waterlogging', 'Other'];
  File? image;
  String? selectedType;
  int currentTypeIndex = -1;
  List<NoteType> noteTypes = [];

  @override
  void initState() {
    super.initState();
    NoteService().getGetNoteType().then((value) {
      noteTypes = value;
    });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image$e');
    }
  }

  DateTime currentDateTime = DateTime.now();
  DateTime chooseDateTime = DateTime.now();
  void changeToNote() {
    setState(() {
      // index_color = 2;
      isFabVisible = true;
      note = !note;
      isFirstWidgetVisible = true;
      isSecondWidgetVisible = false;
      isThirdWidgetVisible = false;
    });
  }

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        isChoose = true;
                        isMarker = false;
                        isFabVisible = true;
                        note = !note;
                        isFirstWidgetVisible = true;
                        isSecondWidgetVisible = false;
                        isThirdWidgetVisible = false;
                      });
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
                      // print(Globals.seasonId);
                      LoadingIndicator(context: context).showLoadingIndicator();
                      await NoteService().createData(titleController.text).then((value) {
                        LoadingIndicator(context: context).hideLoadingIndicator();
                        if (value!) {
                          setState(() {
                            changeToNote();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                            message: 'fail to post',
                          ));
                        }
                        setState(() {
                          isChoose = true;
                          isMarker = false;
                          isFabVisible = true;

                          isFirstWidgetVisible = true;
                          isSecondWidgetVisible = false;
                          isThirdWidgetVisible = false;
                        });
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
              child: TextField(
                maxLines: 3,
                controller: titleController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Таны тэмдэглэл...',
                  border: InputBorder.none,
                ),
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
                setState(() {
                  pickImage();
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
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: image != null
                ? Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ),
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

class Line4 extends StatelessWidget {
  const Line4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black,
          height: 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }
}

class Line5 extends StatelessWidget {
  const Line5({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black,
          height: 0.2,
          width: MediaQuery.of(context).size.width * 0.95,
        ),
      ],
    );
  }
}
