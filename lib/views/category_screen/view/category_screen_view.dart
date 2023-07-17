import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/product_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/dietitian_card_vertical.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreenView extends StatelessWidget {
  final String title;
  const CategoryScreenView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: bodyWidget(context, controller, title),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      leading: const BackButton(color: ColorConstants.darkCharcoal),
      title: Align(
        alignment: Alignment.centerLeft,
        child: title.text
            .fontFamily(FontConstants.medium)
            .color(ColorConstants.darkCharcoal)
            .size(18)
            .make(),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget bodyWidget(
      BuildContext context, ProductController controller, String title) {
    return SafeArea(
      child: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Seçtiğiz kategoride diyetisyen bulunamadı"
                    .text
                    .color(ColorConstants.darkCharcoal)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) => DietitianCardVertical(
                    color: controller.isFav.value
                        ? ColorConstants.red
                        : ColorConstants.darkCharcoal,
                    height: 195,
                    width: 100,
                    textButton:
                        "${data[index]['d_name']} ${data[index]['d_surname']}",
                    image: data[index]['d_imgs'][0],
                    specialty: "${data[index]['d_category']}",
                    experience: "${data[index]['d_experience']}",
                    rating: "${data[index]['d_rating']}",
                    numberofreviews: "${data[index]['d_numberofreviews']}",
                    date:
                        (data[index]['d_nextavailable'] as Timestamp).toDate(),
                  ).onTap(() {
                    controller.checkIfFav(data[index]);
                    Get.to(() => CategoryDetailsView(
                          data: data[index],
                        ));
                  }),
                ),
              );
            }
          }),
    );
  }
}
