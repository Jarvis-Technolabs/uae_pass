import 'package:flutter/material.dart';

extension ImageExtension on String {
  Image getImage({
    double? height = 24.0,
    double? width = 24.0,
    Color? imgColor,
    BoxFit? boxFit,
  }) =>
      Image.asset(
        this,
        height: height,
        width: width,
        color: imgColor,
        fit: boxFit,
      );
}
