import 'package:diyet_asistanim/controllers/product_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/applogo_widget.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/views/card_screen/view/card_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/lists.dart';
import '../../../core/widgets/home_buttons.dart';

class CategoryDetailsView extends StatefulWidget {
  final String? title;
  final String? image;
  final dynamic data;

  const CategoryDetailsView({
    super.key,
    this.title,
    this.image,
    this.data,
  });

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  bool? isCheck = false;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstants.lightGrey,
      appBar: appbar(context, controller, widget.data),
      body: bodyWidget(context, controller),
    );
  }

  AppBar appbar(
      BuildContext context, ProductController controller, dynamic data) {
    return AppBar(
      leading: const BackButton(color: ColorConstants.darkCharcoal),
      title: Align(
        alignment: Alignment.centerLeft,
        child: StringConstants.title.text
            .fontFamily(FontConstants.medium)
            .color(ColorConstants.darkCharcoal)
            .size(18)
            .make(),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: ColorConstants.darkCharcoal)),
        Obx(
          () => IconButton(
              onPressed: () {
                if (controller.isFav.value) {
                  controller.removeFromWishlist(data.id, context);
                } else {
                  controller.addToWishlist(data.id, context);
                }
              },
              icon: Icon(Icons.favorite_rounded,
                  color: controller.isFav.value
                      ? ColorConstants.red
                      : ColorConstants.darkCharcoal)),
        ),
      ],
    );
  }

  Widget bodyWidget(BuildContext context, ProductController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(IconConstants.background.toPng),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        itemCount: widget.data['d_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.data['d_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ).box.rounded.clip(Clip.antiAlias).make();
                        }),
                    20.heightBox,
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child:
                                  "${widget.data['d_name']} ${widget.data['d_surname']}"
                                      .text
                                      .size(16)
                                      .color(ColorConstants.darkCharcoal)
                                      .fontFamily(FontConstants.semibold)
                                      .make(),
                            ),
                            5.heightBox,
                            Row(
                              children: [
                                12.widthBox,
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: ColorConstants.gray,
                                  size: 18,
                                ),
                                3.widthBox,
                                "${widget.data['d_city']} / ${widget.data['d_district']}"
                                    .text
                                    .make(),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40,
                          width: 70,
                          child: Card(
                            semanticContainer: true,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: ColorConstants.goldenrod,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "${widget.data['d_rating']}"
                                    .text
                                    .fontFamily(FontConstants.semibold)
                                    .size(14)
                                    .white
                                    .make(),
                                const Icon(
                                  Icons.star_rounded,
                                  color: ColorConstants.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        15.widthBox,
                      ],
                    ),
                    20.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: "${widget.data['d_desc1']}".text.make(),
                    ),
                    20.heightBox,
                    cardWidget(),
                    20.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: "${widget.data['d_desc2']}".text.make(),
                    ),
                    priceWidget(context),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: CustomButton(
                onPress: () {
                  if (isCheck == true) {
                    controller.addToCard(
                        context: context,
                        img: widget.data['d_imgs'][0],
                        dietitianname: widget.data['d_name'],
                        dietitianID: widget.data['dietitian_id'],
                        surname: widget.data['d_surname'],
                        tprice: widget.data['d_price']);
                    VxToast.show(context, msg: "Sepete eklendi");
                    setState(() {
                      isCheck = false;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Get.to(() => const CardView());
                    });
                  } else {
                    VxToast.show(context, msg: "Bir plan seçeniz");
                  }
                },
                textButton: StringConstants.meeting,
                color: isCheck == true
                    ? ColorConstants.greenCrayola
                    : ColorConstants.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          patients.length,
          (index) => HomeButtons(
              textColor: ColorConstants.darkCharcoal,
              textButton: patients[index],
              text: index == 0
                  ? "${widget.data['d_numberofreviews']}"
                  : index == 1
                      ? "${widget.data['d_experience']}+"
                      : "${widget.data['d_rating']}",
              width: 110,
              height: 90,
              icon: colourfulIcon[index])),
    );
  }

  Widget priceWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 160,
      //color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 70),
            height: 136,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: ColorConstants.greenCrayola,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3))
                ]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: isCheck == true
                      ? ColorConstants.greenCrayola
                      : ColorConstants.white),
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 160,
              width: 150,
              child: Image.asset(
                IconConstants.dinner.toPng,
              ),
            ),
          ),
          Positioned(
              top: 80,
              left: 0,
              child: SizedBox(
                height: 136,
                width: MediaQuery.of(context).size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: 'Ücretisiz Ön Görüşme'
                          .text
                          .fontFamily(FontConstants.semibold)
                          .color(ColorConstants.darkCharcoal)
                          .make(),
                    ),
                    38.heightBox,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15 * 1.5, vertical: 3.5),
                      decoration: const BoxDecoration(
                          color: ColorConstants.greenCrayola,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(22),
                              bottomLeft: Radius.circular(22))),
                      child: "Ücretsiz".text.white.make(),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ).onTap(() {
      setState(() {
        isCheck == false ? isCheck = true : isCheck = false;
      });
    });
  }
}
