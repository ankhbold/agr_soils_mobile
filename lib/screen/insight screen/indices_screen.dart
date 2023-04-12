import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../insight%20screen/insight_screen.dart';

class IndicesScreen extends StatefulWidget {
  const IndicesScreen({super.key});

  @override
  State<IndicesScreen> createState() => _IndicesScreenState();
}

class _IndicesScreenState extends State<IndicesScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0.5),
              blurRadius: 0.1,
            )
          ]),
          child: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: AppColors.grey,
            elevation: 0.0,
            title: Text(
              'indices',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.77,
            height: MediaQuery.of(context).size.height * 0.055,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: currentIndex == index ? const Color(0xff0f766e) : AppColors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            texts[index],
                            style: TextStyle(
                              color: currentIndex == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
