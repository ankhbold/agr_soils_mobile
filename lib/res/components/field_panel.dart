import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../screen/profile_screen.dart';

class FieldPanel extends StatefulWidget {
  final ScrollController controller;

  const FieldPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FieldPanel> createState() => _FieldPanelState();
}

class _FieldPanelState extends State<FieldPanel> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 239, 253, 248),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          controller: widget.controller,
          padding: EdgeInsets.zero,
          children: const <Widget>[
            FirstFieldPanelItem(),
            Line3(),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}

class FirstFieldPanelItem extends StatelessWidget {
  const FirstFieldPanelItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.21,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Container(child: buildNavigator()),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.012,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Тэлэх талбай 3га',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    'add crop',
                    style: TextStyle(fontSize: 15, color: AppColors.Green),
                  )
                ],
              ),
              const SizedBox(
                width: 180,
              ),
              Icon(
                Icons.remove_circle,
                color: Colors.black.withOpacity(0.5),
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildNavigator() => Container(
      padding: const EdgeInsets.only(right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
