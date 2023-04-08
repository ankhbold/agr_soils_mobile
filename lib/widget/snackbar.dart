import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({Key? key, Widget? content, String? message, double? fontSize = 15, Duration? duration})
      : super(
          key: key,
          duration: duration ?? const Duration(seconds: 1),
          content: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                content != null
                    ? Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: content,
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                Flexible(
                  child: Text(
                    message!,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ],
            ),
          ),
        );
}
