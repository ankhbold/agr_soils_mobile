import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/satelite_layer_type.dart';
import '../../services/satelite.dart';
import 'floatingss/first_float.dart';
import 'floatingss/floating_items.dart';

// ignore: must_be_immutable
class StateliteImageType extends StatefulWidget {
  StateliteImageType({this.changeSateliteLayer});
  @override
  State<StatefulWidget> createState() {
    return StateliteImageTypeState();
  }

  Function(String name)? changeSateliteLayer;
}

bool sungahh = true;
int current = -1;

class StateliteImageTypeState extends State<StateliteImageType> {
  List<SateliteLayerType> types = [];
  @override
  void initState() {
    super.initState();
    SateliteService().getSateliteTypes().then((value) {
      types = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height * 0.1;
    final height2 = MediaQuery.of(context).size.height * 0.42;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: sungahh ? height1 : height2,
        width: MediaQuery.of(context).size.width * 0.98,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (sungahh)
              Expanded(flex: 1, child: SizedBox())
            else
              Expanded(
                flex: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SateliteDetailInfo(),
                  ],
                ),
              ),
            Expanded(
              flex: 3,
              child: SizedBox(
                child: FloatingItem(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      itemCount: types.length,
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                            widget.changeSateliteLayer!(types[index].name!);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.01,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.15),
                              color: current == index ? const Color(0xff0f766e) : Color.fromARGB(211, 255, 255, 255),
                            ),
                            child: Center(
                              child: AnimatedContainer(
                                margin: const EdgeInsets.symmetric(horizontal: 12),
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  types[index].name!,
                                  style: TextStyle(
                                    color: current == index ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        sungahh = !sungahh;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.width * 0.11,
                        decoration: BoxDecoration(color: AppColors.Green, borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Icon(
                            Icons.more_horiz,
                            size: 30,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
