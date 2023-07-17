import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveDietitianCard extends StatelessWidget {
  final double width;
  final double height;
  final String image;

  const LiveDietitianCard({
    super.key,
    required this.width,
    required this.height,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.transparent,
        width: width,
        height: height,
        child: Card(
          child: Stack(
            children: [
              Ink.image(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.color),
                height: height,
                width: width,
                fit: BoxFit.cover,
                image: NetworkImage(
                  image,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline,
                  color: ColorConstants.white,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconConstants.live.toImage.paddingOnly(top: 7, right: 7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
