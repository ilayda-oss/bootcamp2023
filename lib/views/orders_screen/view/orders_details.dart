import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/views/chat_view/view/chat_screen.dart';
import 'package:diyet_asistanim/views/orders_screen/components/order_place_details.dart';
import 'package:diyet_asistanim/views/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightGrey,
      appBar: AppBar(
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Randevu Detayları"
            .text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              10.heightBox,
              SizedBox(
                height: 60,
                child: CustomButton(
                    onPress: () {
                      Get.to(() => const ChatScreen(), arguments: [
                        data['orders'][0]['dietitianname'],
                        data['orders'][0]['surname'],
                        data['orders'][0]['dietitian_id']
                      ]);
                    },
                    textButton: "Diyetisyeninle Görüş",
                    color: ColorConstants.greenCrayola),
              ),
              10.heightBox,
              orderStatus(
                  color: ColorConstants.red,
                  icon: Icons.done,
                  title: "Oluşturuldu",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up_alt_rounded,
                  title: "Onaylandı",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Colors.amber.shade900,
                  icon: Icons.phone_iphone_outlined,
                  title: "Görüşülüyor",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Bitti",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(data, "Randevu Kodu", "Paket Türü",
                      data['order_code'], data['shipping_method']),
                  orderPlaceDetails(
                      data,
                      "Randevu Talep Tarihi",
                      "Ödeme Türü",
                      intl.DateFormat('dd.MM.yyyy')
                          .format((data['order_date'].toDate())),
                      data['payment_method']),
                  orderPlaceDetails(
                      data, "Ödeme Durumu", "Durum", "Ödenmedi", "Görüşüldü"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Kullanıcı Adresi"
                                  .text
                                  .fontFamily(FontConstants.semibold)
                                  .make(),
                              "${data['order_by_name']}".text.make(),
                              "${data['order_by_email']}".text.make(),
                              SizedBox(
                                  width: 160,
                                  child: "${data['order_by_address']}"
                                      .text
                                      .make()),
                              "${data['order_by_city']}".text.make(),
                              "${data['order_by_state']}".text.make(),
                              "${data['order_by_phone']}".text.make(),
                              "${data['order_by_postalcode']}".text.make(),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Toplam Tutar"
                                .text
                                .fontFamily(FontConstants.semibold)
                                .make(),
                            "${data['total_amount']} ₺"
                                .text
                                .color(ColorConstants.red)
                                .fontFamily('Roboto')
                                .make(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.color(ColorConstants.lightGrey).make(),
              const Divider(),
              10.heightBox,
              "Randevu İçeriği"
                  .text
                  .size(16)
                  .color(ColorConstants.darkCharcoal)
                  .fontFamily(FontConstants.bold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    children: [
                      orderPlaceDetails(
                          data,
                          "${data['orders'][index]['dietitianname']} ${data['orders'][index]['surname']}",
                          "${data['orders'][index]['tprice']} TL",
                          "${data['shipping_method']}",
                          "${data['payment_method']}"),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .color(ColorConstants.lightGrey)
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
