import 'package:card_loading/card_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/product_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/bg_widget.dart';
import 'package:diyet_asistanim/core/widgets/category_card.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_details_view.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_screen_view.dart';
import 'package:diyet_asistanim/views/home_screen/view/navBar.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/images.dart';
import '../../../core/constants/lists.dart';
import '../../../core/widgets/applogo_widget.dart';
import '../../../core/widgets/dietitian_card_horizontal.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      assetName: IconConstants.background.toPng,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorConstants.darkCharcoal),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: appBarText(),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(IconConstants.background.toPng),
                  fit: BoxFit.cover)),
          child: bodyWidget(context, controller),
        ),
      ),
    );
  }

  Widget appBarText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: StringConstants.dietitian.text
          .color(ColorConstants.darkCharcoal)
          .fontFamily(FontConstants.medium)
          .make(),
    );
  }

  Widget bodyWidget(BuildContext context, ProductController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  populerDietitianWidget(controller),
                ],
              ),
              30.heightBox,
              categoryTextWidget(),
              15.heightBox,
              dietitiansListWidget(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget populerDietitianTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: StringConstants.popularDietitian.text
              .fontFamily(FontConstants.bold)
              .color(ColorConstants.darkCharcoal)
              .size(18)
              .make(),
        ),
        RichText(
            text: const TextSpan(children: [
          TextSpan(
            text: StringConstants.seeAll,
            style: TextStyle(
                fontFamily: FontConstants.medium,
                color: ColorConstants.darkBlueGray,
                fontSize: 12),
          ),
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(Icons.arrow_forward_ios, size: 15),
              ))
        ])).onTap(() {})
      ],
    );
  }

  Widget populerDietitianWidget(ProductController controller) {
    return StreamBuilder(
      stream: FirestoreServices.getPopularDietitian(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CardLoading(
            height: 240,
            width: 170,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          );
        } else {
          var data = snapshot.data!.docs;
          return Column(
            children: [
              populerDietitianTextWidget(),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 240,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 12,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 3, left: 3),
                          child: DietitianCardHorizontal(
                                  height: 200,
                                  width: 170,
                                  textButton:
                                      "${data[index]['d_name']} ${data[index]['d_surname']}",
                                  image: data[index]['d_imgs'][0],
                                  specialty: data[index]['d_category'])
                              .onTap(() {
                            Get.to(() => CategoryDetailsView(
                                  data: data[index],
                                ));
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget categoryTextWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: StringConstants.category.text
          .fontFamily(FontConstants.bold)
          .color(ColorConstants.darkCharcoal)
          .size(18)
          .make(),
    );
  }

  Widget dietitiansListWidget(
      BuildContext context, ProductController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: category.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 3, left: 3),
          child: CategoryCard(
            height: 100,
            width: 100,
            textButton: category[index],
          ).onTap(() {
            controller.getSubCategories(category[index]);
            Get.to(() => CategoryScreenView(title: category[index]));
          }),
        ),
      ),
    );
  }
}
