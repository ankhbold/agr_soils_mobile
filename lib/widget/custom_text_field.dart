import 'dart:io';

// import 'package:car_market/themes/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'keyboard.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
      this.controller,
      this.readOnly,
      this.prefix,
      this.suffix,
      this.labelText,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.onTap,
      this.onEditingComplete,
      this.onSaved,
      this.onFieldSubmitted,
      this.onChanged,
      this.autoCorrect,
      this.focusNode,
      this.maxLength,
      this.icon,
      this.iconOnPressed,
      this.suffixIconOnPressed,
      this.isBorder = true,
      this.borderRadius,
      this.enabledBorder,
      this.disabledBorder,
      this.focusedBorder,
      this.textInputAction,
      this.onDone,
      required this.context,
      this.validator,
      this.inputFormatters})
      : super(key: key);
  TextEditingController? controller;
  bool? readOnly;
  Widget? prefix;
  Widget? suffix;
  String? labelText;
  bool? obscureText;
  TextInputType? textInputType;
  Function? onTap;
  Function? onEditingComplete;
  Function(String value)? onFieldSubmitted;
  Function(String value)? onChanged;
  final ValueChanged<String>? onSaved;
  Function? iconOnPressed;
  Function? suffixIconOnPressed;
  Function? onDone;
  bool? autoCorrect;
  FocusNode? focusNode;
  int? maxLength;
  bool? isBorder;
  double? borderRadius;
  Widget? icon;
  InputBorder? enabledBorder;
  InputBorder? disabledBorder;
  InputBorder? focusedBorder;
  TextInputAction? textInputAction;
  BuildContext? context;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<StatefulWidget> createState() {
    return CustomTextFieldState();
  }
}

class CustomTextFieldState extends State<CustomTextField> {
  OverlayEntry? overlayEntry;
  FocusNode _focusNode = new FocusNode();
  bool autoValidateEnabled = false;
  @override
  void initState() {
    super.initState();
    widget.controller!.addListener(() {
      checkCanAutoValidate(widget.controller!.text);
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (((widget.textInputType == TextInputType.phone ||
                  widget.textInputType == TextInputType.number ||
                  widget.textInputType == TextInputType.multiline) &&
              widget.textInputAction == TextInputAction.done) &&
          Platform.isIOS) {
        FocusNode? focusNode1 = widget.focusNode != null ? widget.focusNode : _focusNode;
        focusNode1!.addListener(() {
          bool hasFocus = focusNode1.hasFocus;
          if (hasFocus) {
            showOverlay(widget.context!);
          } else
            removeOverlay();
        });

        // KeyboardVisibilityNotification().addNewListener(
        //   onHide: () {
        //     removeOverlay();
        //   },
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.textInputType == TextInputType.multiline ? null : 1,
      validator: widget.validator,
      maxLength: widget.maxLength,
      focusNode: widget.focusNode ?? _focusNode,
      obscureText: widget.obscureText!,
      key: widget.key,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly ?? false,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: const Color(0xff000000),
          ),
      keyboardType: widget.textInputType,
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      textInputAction: widget.textInputAction,
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      autocorrect: widget.autoCorrect ?? false,
      onEditingComplete: () {
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!();
        }

        // if (widget.focusNode != null)
        //   widget.focusNode!.nextFocus();
        // else
        //   _focusNode.nextFocus();
      },
      autovalidateMode: autoValidateEnabled ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {
        if (widget.focusNode != null)
          widget.focusNode!.nextFocus();
        else
          _focusNode.nextFocus();
        if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(value);
      },
      onSaved: (val) {
        if (widget.focusNode != null)
          widget.focusNode!.nextFocus();
        else
          _focusNode.nextFocus();
        if (widget.onSaved != null) widget.onSaved!(val!);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, bottom: 15, top: 15, right: 0),
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix != null
            ? GestureDetector(
                onTap: () {
                  if (widget.suffixIconOnPressed != null) widget.suffixIconOnPressed!();
                },
                child: widget.suffix,
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
        labelText: widget.labelText ?? "",
        // filled: true,
        border: widget.isBorder!
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 18),
                ),
              )
            : InputBorder.none,
        disabledBorder: widget.isBorder!
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 18),
                ),
              )
            : InputBorder.none,
        enabledBorder: widget.isBorder!
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 18),
                ),
              )
            : InputBorder.none,
        focusedBorder: widget.isBorder!
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 18),
                ),
              )
            : InputBorder.none,
        labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: const Color(0xffA2A2A6),
            ),
        suffix: widget.icon != null
            ? GestureDetector(
                onTap: () {
                  widget.iconOnPressed!();
                },
                child: widget.icon!,
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
      ),
      cursorColor: Colors.green,
    );
  }

  checkCanAutoValidate(String val) {
    if (val.isNotEmpty) {
      setState(() {
        autoValidateEnabled = true;
      });
    } else {
      setState(() {
        autoValidateEnabled = false;
      });
    }
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;

    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0.0,
        left: 0.0,
        child: InputDoneView(
          onDone: widget.onDone ??
              () {
                if (widget.focusNode != null)
                  widget.focusNode!.nextFocus();
                else
                  _focusNode.nextFocus();
              },
        ),
      );
    });
    overlayState!.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
