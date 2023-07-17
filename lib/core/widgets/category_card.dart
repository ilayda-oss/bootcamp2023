import 'package:diyet_asistanim/core/constants/colors.dart';

import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryCard extends StatelessWidget {
  final VoidCallback? functionApply;
  final String textButton;
  final double width;
  final double height;

  const CategoryCard({
    super.key,
    this.functionApply,
    required this.textButton,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: textButton.text
                .fontFamily(FontConstants.medium)
                .color(ColorConstants.darkCharcoal)
                .align(TextAlign.center)
                .maxLines(2)
                .make(),
          ),
        ],
      ),
    );
  }
}
