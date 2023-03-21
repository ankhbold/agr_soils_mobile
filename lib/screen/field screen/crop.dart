import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';

class Crop extends StatefulWidget {
  const Crop({super.key});

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.Green,
                  size: 15,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(color: AppColors.Green),
                ),
              ],
            ),
          ),
        ),
        actions: [],
        title: Text(
          'crop rotation',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(),
        ),
      ),
    );
  }
}
