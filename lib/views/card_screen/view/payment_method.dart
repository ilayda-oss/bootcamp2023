import 'package:diyet_asistanim/controllers/cart_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/lists.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/views/home_screen/view/home_screen.dart';
import 'package:get/get.dart';

class PaymentMethos extends StatelessWidget {
  const PaymentMethos({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstants.lightGrey,
        appBar: AppBar(
          leading: const BackButton(color: ColorConstants.darkCharcoal),
          title: Align(
            alignment: Alignment.centerLeft,
            child: "Ödeme Yöntemi"
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
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(ColorConstants.greenCrayola)))
              : CustomButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    // ignore: use_build_context_synchronously
                    VxToast.show(context,
                        msg: "Randevu isteğiniz başarıyla alındı");
                    Get.offAll(const HomeScreen());
                  },
                  textButton: "Randevuyu Tamamla",
                  color: ColorConstants.greenCrayola),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? ColorConstants.red
                            : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodsImg[index].toPng,
                        width: double.infinity,
                        height: 120,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: ColorConstants.greenCrayola,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(FontConstants.semibold)
                              .make()),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
