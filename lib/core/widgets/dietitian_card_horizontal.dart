import 'package:diyet_asistanim/core/constants/colors.dart';

import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DietitianCardHorizontal extends StatelessWidget {
  final VoidCallback? functionApply;
  final String textButton;
  final String specialty;
  final String image;
  final double width;
  final double height;

  const DietitianCardHorizontal({
    super.key,
    this.functionApply,
    required this.textButton,
    required this.image,
    required this.specialty,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 27,
      height: height + 10,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.gray.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: width,
              height: width,
              fit: BoxFit.cover,
            ),
          ),
          5.heightBox,
          Expanded(
            child: textButton.text
                .fontFamily(FontConstants.medium)
                .color(ColorConstants.darkCharcoal)
                .size(14)
                .center
                .make(),
          ),
          5.heightBox,
          Expanded(
            child: specialty.text
                .size(10)
                .align(TextAlign.center)
                .fontFamily(FontConstants.light)
                .color(ColorConstants.darkBlueGray)
                .make(),
          ),
          5.heightBox,
        ],
      ),
    );
  }
}
