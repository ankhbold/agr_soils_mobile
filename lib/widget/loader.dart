import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator {
  BuildContext? context;
  LoadingIndicator({this.context});
  showLoadingIndicator() async {
    await showDialog(
      useSafeArea: true,
      context: context!,
      builder: (context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: SpinKitCircle(
                color: Colors.green,
                size: 50.0,
              ),
            ));
      },
    );
  }

  hideLoadingIndicator() {
    Navigator.pop(context!);
  }
}
