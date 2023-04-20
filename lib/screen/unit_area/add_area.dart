import 'package:flutter/material.dart';

import '../../widget/line.dart';
import '../../widget/outlined_btn.dart';

class AddField extends StatelessWidget {
  AddField({super.key, this.clear, this.undo, this.next});
  Function? clear;
  Function? undo;
  Function? next;
  Function? success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Color(0xffECECEC), borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      undo!();
                    },
                    icon: Icon(
                      Icons.undo_rounded,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  child: CustomOutlinedBtn(
                    color: Colors.green,
                    textColor: Colors.white,
                    text: 'Дараагийн',
                    onTap: () {
                      next!();
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Line4(),
          InkWell(
            child: Ink(
              width: 100,
              decoration: BoxDecoration(),
              height: MediaQuery.of(context).size.height * 0.06,
              child: TextButton(
                onPressed: () {
                  clear!();
                },
                child: Text(
                  'Буцах',
                  style: TextStyle(color: Color.fromARGB(255, 183, 45, 37), fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
