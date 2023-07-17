import 'package:diyet_asistanim/core/widgets/applogo_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/images.dart';
export 'package:flutter/material.dart';

Widget applogoWidget() {
  return Image.asset(IconConstants.logo.toPng)
      .box
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}

Widget applogoBlackWidget() {
  return Image.asset(IconConstants.logo.toPng)
      .box
      .black
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
