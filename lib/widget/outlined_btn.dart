import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomOutlinedBtn extends StatelessWidget {
  CustomOutlinedBtn({
    Key? key,
    this.text,
    this.color,
    this.textColor,
    this.height,
    this.onTap,
    this.icon,
    this.elevation,
    this.width,
    this.content,
    this.borderRadius,
  }) : super(key: key);
  String? text;
  Color? color;
  Color? textColor;
  double? height;
  Function? onTap;
  Widget? icon;
  double? elevation;
  double? width;
  Widget? content;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: OutlinedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 50),
                side: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Colors.red,
                  strokeAlign: 0,
                )),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            onTap != null ? color ?? Colors.transparent : Colors.grey,
          ),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: onTap != null
            ? () {
                onTap!();
              }
            : null,
        child: Center(
          child: content ??
              Text(
                text ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: textColor ?? const Color(0xff000000), fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
