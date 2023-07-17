import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/orders_screen/view/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/images.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Randevular"
            .text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                ),
              ),
            );
          } else if (snapshot.data!.docChanges.isEmpty) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Center(
                  child: "Henüz randevunuz yok!"
                      .text
                      .fontFamily(FontConstants.semibold)
                      .size(17)
                      .color(ColorConstants.darkCharcoal)
                      .makeCentered(),
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(FontConstants.bold)
                          .color(ColorConstants.darkCharcoal)
                          .xl
                          .make(),
                      title:
                          "${data[index]['orders'][0]['dietitianname']} ${data[index]['orders'][0]['surname']}"
                              .text
                              .color(ColorConstants.red)
                              .fontFamily(FontConstants.semibold)
                              .make(),
                      subtitle: "${data[index]['shipping_method']}"
                          .toString()
                          .text
                          .fontFamily(FontConstants.bold)
                          .make(),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrdersDetails(data: data[index]));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: ColorConstants.darkCharcoal,
                          )),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
