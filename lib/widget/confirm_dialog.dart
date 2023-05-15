import 'package:flutter/material.dart';
import 'package:mvvm/themes/styles.dart';

import 'custom_outlined_btn.dart';

// ignore: must_be_immutable
class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({Key? key, this.isSuccess = false, this.isError = false, this.isAlert = false, this.text})
      : super(key: key);
  bool? isSuccess;
  bool? isError;
  bool? isAlert;
  String? text;
  @override
  Widget build(BuildContext context) {
    Icon? icon;
    Color? color;
    String? title;
    if (isSuccess!) {
      icon = const Icon(
        Icons.check,
        size: 30,
        color: Colors.white,
      );
      title = "Амжилттай";
      color = const Color(0xff70C217);
    } else if (isAlert!) {
      icon = const Icon(
        Icons.priority_high,
        size: 30,
        color: Colors.white,
      );
      title = "Анхааруулга";
      color = Colors.yellow;
    } else {
      icon = const Icon(
        Icons.close,
        size: 30,
        color: Colors.white,
      );
      title = "Амжилтгүй";
      color = Colors.red;
    }
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
              child: icon),
        ],
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: primaryColor, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text!,
            style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: const Color(0xff30359F).withOpacity(0.7)),
            textAlign: TextAlign.center,
          )
        ],
      ),
      elevation: 5,
      titlePadding: const EdgeInsets.all(40),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(26))),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      actions: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  color: primaryColor,
                  height: 40,
                  text: "Тийм",
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomOutlinedButton(
                  color: primaryColor,
                  height: 40,
                  text: "Үгүй",
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
