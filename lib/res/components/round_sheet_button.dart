import 'package:flutter/material.dart';

class RoundSheetButton extends StatelessWidget {
  const RoundSheetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.045,
      width: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.7),
      ),
      child: FloatingActionButton.extended(
        heroTag: "btn3",
        backgroundColor: Colors.white.withOpacity(0.75),
        onPressed: () => showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 50, left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.27,
              );
            }),
        label: Image.asset(
          'assets/images/image.png',
        ),
      ),
    );
  }
}
