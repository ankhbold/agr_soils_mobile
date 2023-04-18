import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

class MyCachedNetworkImage extends StatelessWidget {
  String? imageUrl;
  BoxFit? fit;
  double? borderRadius;
  bool? isPlaceHolder;

  MyCachedNetworkImage({
    Key? key,
    this.imageUrl,
    this.fit,
    this.borderRadius,
    this.isPlaceHolder = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: imageUrl!,
      fit: fit ?? BoxFit.contain,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xffECECEC),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        );
      },
      placeholder: isPlaceHolder!
          ? (context, url) {
              return LoadingIndicatorWidget(
                loaderColor: Colors.green,
              );
            }
          : null,
    );
  }
}
