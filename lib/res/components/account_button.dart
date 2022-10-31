import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountButton extends StatelessWidget {
  final Icon icon;
  final Text text;
  final Icon icon2;
  final VoidCallback onTap;
  const AccountButton({
    super.key,
    required this.icon,
    required this.text,
    required this.icon2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => onTap(),
      child: InkWell(
        highlightColor: Colors.black.withOpacity(0.1),

        // splashColor: Colors.black,
        onTap: () {
          onTap();
        },
        child: Ink(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              icon,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              text,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  icon2,
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
