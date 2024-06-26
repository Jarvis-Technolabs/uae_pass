import 'dart:core';

import 'package:flutter/material.dart';

///Useful when you want customize the default app bar UI
class AppBarProperties {
  Color? backgroundColor;
  Widget? titleWidget;
  double? titleSpacing;
  bool? centerTitle;
  bool? automaticallyImplyLeading;
  Widget? backIcon;
  double? elevation;
  List<Widget>? actions;
  Color? shadowColor;

  AppBarProperties({
    this.backgroundColor,
    this.titleWidget,
    this.titleSpacing,
    this.centerTitle,
    this.automaticallyImplyLeading,
    this.backIcon,
    this.elevation,
    this.actions,
    this.shadowColor,
  });
}
