import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeButtons extends StatelessWidget {
  final VoidCallback? functionApply;
  final String? textButton;
  final String? text;
  final double width;
  final double height;

  final IconData? icon;
  final String? colors;
  final Color? textColor;

  const HomeButtons(
      {super.key,
      this.functionApply,
      required this.textButton,
      required this.width,
      required this.height,
      required this.icon,
      this.colors,
      this.text,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(colors ?? IconConstants.card5.toPng),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          13.heightBox,
          Visibility(
            visible: text.isEmptyOrNull,
            child: Icon(
              icon,
              color: ColorConstants.white,
              size: 32,
            ),
          ),
          Visibility(
            visible: text.isNotEmptyAndNotNull,
            child: Expanded(
                child: (text ?? '')
                    .text
                    .fontFamily(FontConstants.bold)
                    .color(ColorConstants.lightseagreen)
                    .size(25)
                    .align(TextAlign.center)
                    .make()),
          ),
          7.heightBox,
          Expanded(
            child: (textButton ?? '')
                .text
                .fontFamily(FontConstants.light)
                .color(textColor ?? ColorConstants.white)
                .size(10)
                .maxLines(2)
                .align(TextAlign.center)
                .make(),
          ),
        ],
      )
          .box
          .customRounded(BorderRadius.circular(8))
          .color(colors == null ? const Color(0xFFE1F6F4) : Colors.transparent)
          .size(width, height)
          .make(),
    );
  }
}
