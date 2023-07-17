import 'package:diyet_asistanim/controllers/bmi_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class BmiView extends StatelessWidget {
  const BmiView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BmiController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const BackButton(color: ColorConstants.darkCharcoal),
          title: Align(
            alignment: Alignment.centerLeft,
            child: "Diyet programı"
                .text
                .fontFamily(FontConstants.medium)
                .color(ColorConstants.darkCharcoal)
                .size(18)
                .make(),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(IconConstants.background.toPng),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) =>
                          controller.userHeight.value = double.parse(value),
                      decoration: InputDecoration(
                        labelText: "Height in cm",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    20.heightBox,
                    TextField(
                      onChanged: (value) =>
                          controller.userWeight.value = double.parse(value),
                      decoration: InputDecoration(
                        labelText: "Weight in kg",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    20.heightBox,
                    Obx(() => Text(
                        "Your BMI is ${controller.bmiResult.value.toStringAsFixed(2)}"))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
