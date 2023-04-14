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
    Navigator.of(context!, rootNavigator: true).pop();
  }
}

class LoadingIndicatorWidget extends StatelessWidget {
  final Color? loaderColor;
  final double? size;

  LoadingIndicatorWidget({Key? key, this.loaderColor, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SpinKitCircle(
        duration: const Duration(seconds: 2),
        color: loaderColor ?? Colors.white,
        size: size!,
      ),
    );
  }
}
