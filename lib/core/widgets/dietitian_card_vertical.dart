import 'package:diyet_asistanim/controllers/product_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';

import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class DietitianCardVertical extends StatelessWidget {
  final VoidCallback? functionApply;
  final Color? color;
  final String textButton;
  final String specialty;
  final String image;
  final DateTime date;
  final String rating;
  final String numberofreviews;
  final String experience;
  final double width;
  final double height;

  const DietitianCardVertical({
    super.key,
    this.functionApply,
    required this.textButton,
    required this.image,
    required this.specialty,
    required this.width,
    required this.height,
    this.color,
    required this.experience,
    required this.rating,
    required this.numberofreviews,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.gray.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 3, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 98,
                width: 87,
                margin: const EdgeInsets.only(right: 17, left: 20, top: 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textButton.text
                        .fontFamily(FontConstants.medium)
                        .color(ColorConstants.darkCharcoal)
                        .size(18)
                        .make(),
                    6.heightBox,
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: specialty.text
                          .size(13)
                          .overflow(TextOverflow.visible)
                          .fontFamily(FontConstants.medium)
                          .color(ColorConstants.greenCrayola)
                          .make(),
                    ),
                    4.heightBox,
                    "$experience yıllık deneyim"
                        .text
                        .size(12)
                        .color(ColorConstants.darkBlueGray)
                        .fontFamily(FontConstants.light)
                        .make(),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.brightness_1,
                          color: ColorConstants.greenCrayola,
                          size: 10,
                        ),
                        5.widthBox,
                        "$rating puan"
                            .text
                            .color(ColorConstants.darkBlueGray)
                            .fontFamily(FontConstants.light)
                            .size(10)
                            .make(),
                        20.widthBox,
                        const Icon(
                          Icons.brightness_1,
                          color: ColorConstants.greenCrayola,
                          size: 10,
                        ),
                        5.widthBox,
                        "$numberofreviews görüşme"
                            .text
                            .color(ColorConstants.darkBlueGray)
                            .fontFamily(FontConstants.light)
                            .size(10)
                            .make(),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Icon(Icons.favorite,
                        color: controller.isFav.value
                            ? ColorConstants.red
                            : ColorConstants.darkCharcoal))
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, bottom: 18, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Uygun Zaman"
                        .text
                        .size(13)
                        .fontFamily(FontConstants.regular)
                        .color(ColorConstants.greenCrayola)
                        .make(),
                    5.heightBox,
                    "${intl.DateFormat('dd.MM.yyyy - HH:mm').format(date)} "
                        .text
                        .color(ColorConstants.darkBlueGray)
                        .size(12)
                        .fontFamily(FontConstants.light)
                        .make(),
                  ],
                ),
                SizedBox(
                  width: 112,
                  height: 36,
                  child: CustomButton(
                      onPress: () {},
                      textButton: "Randevu Al",
                      color: ColorConstants.greenCrayola),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
