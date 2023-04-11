import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDoneView extends StatelessWidget {
  final onDone;

  InputDoneView({this.onDone});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Color.fromRGBO(217, 217, 217, 1),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 0,
              color: Theme.of(context).primaryColorDark,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: CupertinoButton(
                  padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (this.onDone != null) {
                      this.onDone();
                    }
                  },
                  child: Text("Болсон",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ));
  }
}
