import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String textButton;
  final Color color;

  const CustomButton(
      {super.key,
      required this.onPress,
      required this.textButton,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color,
          padding: const EdgeInsets.all(12),
        ),
        child: textButton.text.white.fontFamily(FontConstants.bold).make(),
      ),
    );
  }
}
