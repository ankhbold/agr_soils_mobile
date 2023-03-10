import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm/constants/color.dart';
import 'package:mvvm/screen/field%20screen/field.dart';
import 'package:mvvm/screen/notes%20screen/screen_three.dart';
import 'package:mvvm/service/remote_services.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  File? image;
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
  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ScreenThree(),
                      //   ),
                      // );
                      // print(DateTime.now());
                      bool response =
                          await repository.createData(titleController.text);
                      if (response) {
                        setState(() {
                          changeToNote();
                        });
                      } else {
                        throw Exception('fail to post');
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
          Line5(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: image != null
                ? Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      color: Color.fromARGB(255, 212, 212, 212),
                    ),
                    child: Center(child: Text('data')),
                  ),
          )
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
