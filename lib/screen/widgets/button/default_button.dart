import 'package:flutter/material.dart';

import '../../profile screen/profile_screen.dart';

class DefaultButton extends StatefulWidget {
  final VoidCallback OnTap;
  final String text;
  DefaultButton({super.key, required this.OnTap, required this.text});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.OnTap,
      child: Ink(
        child: Column(
          children: [
            Line2(),
            Container(
              height: 50,
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Line2()
          ],
        ),
      ),
    );
  }
}
