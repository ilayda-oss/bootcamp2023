import 'package:card_loading/card_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/home_controller.dart';
import 'package:diyet_asistanim/controllers/product_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/lists.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/dietitian_card_horizontal.dart';
import 'package:diyet_asistanim/core/widgets/home_buttons.dart';
import 'package:diyet_asistanim/core/widgets/live_dietitian_card.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/assistant_view/view/assistan_screen.dart';
import 'package:diyet_asistanim/views/bmi_view/bmi_view.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_details_view.dart';
import 'package:diyet_asistanim/views/category_screen/view/search_screen.dart';
import 'package:diyet_asistanim/views/home_screen/view/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/widgets/applogo_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var searchController = Get.find<HomeController>();
    var controller = Get.put(ProductController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: const NavBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.transparent, size: 60),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getUser(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorConstants.greenCrayola),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(IconConstants.background.toPng),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                      height: size.height * 0.24,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.24 - 27,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(IconConstants.back.toPng),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      20.heightBox,
                                      'Hoş geldin ${data['name']} !'
                                          .text
                                          .color(ColorConstants.white)
                                          .fontFamily(FontConstants.medium)
                                          .size(20)
                                          .make(),
                                      5.heightBox,
                                      'Diyetisyenini bul'
                                          .text
                                          .color(ColorConstants.white)
                                          .fontFamily(FontConstants.bold)
                                          .size(25)
                                          .make(),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                          image: data['imageUrl'] == ''
                                              ? AssetImage(
                                                      IconConstants.user.toPng)
                                                  as ImageProvider
                                              : NetworkImage(data['imageUrl']),
                                          fit: BoxFit.cover,
                                        )),
                                  ).onTap(() {
                                    Scaffold.of(context).openEndDrawer();
                                  }),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 54,
                                child: searchTextField(searchController),
                              )),
                        ],
                      )),
                  10.heightBox,
                  bodyWidget(context, controller),
                ],
              ),
            ).box.make();
          }
        },
      ),
    );
  }

  Widget searchTextField(HomeController controller) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      child: TextFormField(
        controller: controller.searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: ColorConstants.greenCrayola,
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              controller.searchController.text = "";
            },
          ),
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              if (controller.searchController.text.isNotEmptyAndNotNull) {
                Get.to(() => SearchScreen(
                      title: controller.searchController.text.trim(),
                    ));
              }
            },
          ),
          filled: true,
          fillColor: ColorConstants.white,
          hintText: StringConstants.searchHint,
          hintStyle: const TextStyle(color: ColorConstants.darkBlueGray),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context, ProductController controller) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Column(
            children: [
              //vxSwiperWidget(),
              liveDietitianListWidget(context, controller),
              20.heightBox,
              cardWidget(context),
              20.heightBox,
              populerDietitianList(context, controller),
              20.heightBox,
              anlystWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget liveDietitianListWidget(
      BuildContext context, ProductController controller) {
    return StreamBuilder(
      stream: FirestoreServices.getOnlineDietitian(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CardLoading(
            height: 168,
            width: 116,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: "Şuan da online diyetisyen yok!"
                .text
                .color(ColorConstants.darkCharcoal)
                .make(),
          );
        } else {
          var data = snapshot.data!.docs;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: StringConstants.liveDietitian.text
                        .fontFamily(FontConstants.medium)
                        .color(ColorConstants.darkCharcoal)
                        .size(15)
                        .make(),
                  ),
                ],
              ),
              5.heightBox,
              Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      separatorBuilder: (context, _) => const SizedBox(
                        width: 3,
                      ),
                      itemBuilder: (context, index) => LiveDietitianCard(
                              height: 168,
                              width: 116,
                              image: data[index]['d_imgs'][0])
                          .onTap(() {
                        Get.to(() => CategoryDetailsView(data: data[index]));
                      }),
                    ),
                  ),
                ],
              ).box.size(MediaQuery.of(context).size.width, 168).make(),
            ],
          );
        }
      },
    );
  }

  Widget vxSwiperWidget() {
    return VxSwiper.builder(
        aspectRatio: 16 / 5,
        autoPlay: true,
        height: 150,
        enlargeCenterPage: true,
        itemCount: dietitianLisImage.length,
        itemBuilder: (context, index) {
          return Image.asset(dietitianLisImage[index].toPng,
                  fit: BoxFit.fitWidth, width: 300)
              .box
              .rounded
              .clip(Clip.antiAlias)
              .margin(const EdgeInsets.symmetric(horizontal: 8))
              .make();
        });
  }

  Widget cardWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          listColor.length,
          (index) => HomeButtons(
                colors: listColor[index].toPng,
                textButton: colourfulText[index],
                width: 80,
                height: 90,
                icon: colourfulIcon[index],
              ).onTap(() {
                index == 0
                    ? Get.to(() => const AssistanScreen())
                    : index == 2
                        ? Get.to(() => const BmiView())
                        : null;
              })),
    );
  }

  Widget populerDietitianList(
      BuildContext context, ProductController controller) {
    return StreamBuilder(
      stream: FirestoreServices.getPopularDietitian(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CardLoading(
            height: 260,
            width: 190,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          );
        } else {
          var data = snapshot.data!.docs;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: StringConstants.popularDietitian.text
                        .fontFamily(FontConstants.medium)
                        .color(ColorConstants.darkCharcoal)
                        .size(15)
                        .make(),
                  ),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: StringConstants.seeAll,
                      style: TextStyle(
                          fontFamily: FontConstants.medium,
                          color: ColorConstants.darkCharcoal,
                          fontSize: 15),
                    ),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.arrow_forward_ios, size: 15),
                        ))
                  ])).onTap(() {})
                ],
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      separatorBuilder: (context, _) => const SizedBox(
                        width: 12,
                      ),
                      itemBuilder: (context, index) => DietitianCardHorizontal(
                              height: 260,
                              width: 190,
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
                ],
              ).box.size(MediaQuery.of(context).size.width, 265).make(),
            ],
          );
        }
      },
    );
  }

  Widget anlystWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: StringConstants.popularDietitian.text
              .fontFamily(FontConstants.medium)
              .color(ColorConstants.darkCharcoal)
              .size(15)
              .make(),
        ),
      ],
    );
  }
}
