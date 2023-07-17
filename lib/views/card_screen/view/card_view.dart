import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/cart_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/card_screen/view/shipping_view.dart';
import 'package:diyet_asistanim/views/home_screen/view/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var controller = Get.put(CartController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorConstants.darkCharcoal),
          title: Align(
            alignment: Alignment.centerLeft,
            child: "Randevu Ekranı"
                .text
                .color(ColorConstants.darkCharcoal)
                .fontFamily(FontConstants.medium)
                .make(),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCard(uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(ColorConstants.greenCrayola)),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.background.toPng),
                          fit: BoxFit.cover)),
                  child: SafeArea(
                    child: Column(
                      children: [
                        80.heightBox,
                        Image.asset(IconConstants.illu.toPng),
                        30.heightBox,
                        "Randevu ekranı boş"
                            .text
                            .fontFamily(FontConstants.regular)
                            .size(20)
                            .color(ColorConstants.darkCharcoal)
                            .make(),
                        20.heightBox,
                        "İlk randevunu oluştur"
                            .text
                            .fontFamily(FontConstants.light)
                            .size(14)
                            .color(ColorConstants.darkCharcoal)
                            .make(),
                      ],
                    ),
                  ),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.background.toPng),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "${data[index]['img']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title:
                                        "${data[index]['dietitianname']} ${data[index]['surname']}"
                                            .text
                                            .fontFamily(FontConstants.semibold)
                                            .size(16)
                                            .make(),
                                    subtitle: "15 dakikalık ön görüşme"
                                        .text
                                        .color(ColorConstants.darkCharcoal)
                                        .fontFamily(FontConstants.medium)
                                        .color(ColorConstants.red)
                                        .size(10)
                                        .make(),
                                    trailing: const Icon(
                                      Icons.delete_rounded,
                                      color: ColorConstants.red,
                                    ).onTap(() {
                                      FirestoreServices.deleteDocument(
                                          data[index].id);
                                    }),
                                  );
                                })),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Toplan Fiyat"
                                .text
                                .fontFamily(FontConstants.medium)
                                .color(ColorConstants.darkCharcoal)
                                .make(),
                            Obx(
                              () => "${controller.totalP.value} ₺"
                                  .text
                                  .fontFamily(FontConstants.medium)
                                  .color(ColorConstants.darkCharcoal)
                                  .make(),
                            ),
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(12))
                            .color(ColorConstants.greenCrayola.withOpacity(0.7))
                            .roundedSM
                            .make(),
                        10.heightBox,
                        SizedBox(
                          height: 60,
                          child: CustomButton(
                              onPress: () {
                                Get.to(() => const ShippingView());
                              },
                              textButton: "Randevu Al",
                              color: ColorConstants.greenCrayola),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
