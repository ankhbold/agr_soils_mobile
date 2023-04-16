import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomOutlinedIconBtn extends StatelessWidget {
  CustomOutlinedIconBtn({
    Key? key,
    this.text,
    this.color,
    this.textColor,
    this.height,
    this.onTap,
    required this.icon,
    this.borderColor,
    this.isPrefix = false,
    this.borderRadius,
  }) : super(key: key);
  String? text;
  Color? color;
  Color? textColor;
  double? height;
  Function? onTap;
  Widget? icon;
  Color? borderColor;
  bool? isPrefix;
  double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 50),
              side: const BorderSide(
                width: 0,
                style: BorderStyle.none,
                color: Colors.red,
                strokeAlign: 0,
              ),
            ),
          ),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          backgroundColor: MaterialStateProperty.all<Color>(color ?? Colors.transparent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.88,
            ),
          ),
        ),
        onPressed: () {
          onTap!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isPrefix! ? Container(child: icon ?? Container()) : Container(),
            isPrefix!
                ? const SizedBox(
                    width: 7,
                  )
                : Container(),
            Flexible(
              flex: 3,
              child: AutoSizeText(
                text!,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: textColor ?? const Color(0xff000000),
                    ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            !isPrefix!
                ? const SizedBox(
                    width: 7,
                  )
                : Container(),
            !isPrefix! ? Container(child: icon != null ? Flexible(child: icon!) : Container()) : Container()
          ],
        ),
      ),
    );
  }
}
