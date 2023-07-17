import 'package:diyet_asistanim/controllers/cart_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/core/widgets/custom_textfield.dart';
import 'package:diyet_asistanim/views/card_screen/view/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingView extends StatelessWidget {
  const ShippingView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.lightGrey,
      appBar: AppBar(
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        title: Align(
          alignment: Alignment.centerLeft,
          child: "Randevu Bilgileri"
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
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethos());
              } else {
                VxToast.show(context, msg: "Lütfen formu doldurunuz");
              }
            },
            textButton: "Devam",
            color: ColorConstants.greenCrayola),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Adres",
                isPass: false,
                controller: controller.addressController),
            customTextField(
                hint: "Şehir",
                isPass: false,
                controller: controller.cityController),
            customTextField(
                hint: "Mahalle",
                isPass: false,
                controller: controller.stateController),
            customTextField(
                hint: "Posta Kodu",
                isPass: false,
                controller: controller.postalController),
            customTextField(
                hint: "Telefon Numarası",
                isPass: false,
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
