import 'package:card_loading/card_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/auth_controller.dart';
import 'package:diyet_asistanim/controllers/profile_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/lists.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/home_buttons.dart';
import 'package:diyet_asistanim/core/widgets/profile_menu_widget.dart';
import 'package:diyet_asistanim/services/firestore_services.dart';
import 'package:diyet_asistanim/views/auth_view/view/login_view.dart';
import 'package:diyet_asistanim/views/chat_view/view/messaging_screen.dart';
import 'package:diyet_asistanim/views/home_screen/view/navBar.dart';
import 'package:diyet_asistanim/views/orders_screen/view/orders_view.dart';
import 'package:diyet_asistanim/views/profile_screen/view/update_profile_view.dart';
import 'package:diyet_asistanim/views/wishlist_screen/view/wishlist_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var controller = Get.put(ProfileController());

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstants.darkCharcoal),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: StringConstants.myProfile.text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: ColorConstants.darkCharcoal,
              )),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: StreamBuilder(
          stream: FirestoreServices.getUser(uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                  image: data['imageUrl'] == ''
                                      ? AssetImage(IconConstants.user.toPng)
                                          as ImageProvider
                                      : NetworkImage(data['imageUrl']),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      ),
                      10.heightBox,
                      '${data['name']} ${data['surname']}'
                          .text
                          .color(ColorConstants.darkCharcoal)
                          .fontFamily(FontConstants.semibold)
                          .size(22)
                          .make(),
                      '${data['email']}'
                          .text
                          .color(ColorConstants.darkCharcoal)
                          .fontFamily(FontConstants.medium)
                          .size(15)
                          .make(),
                      20.heightBox,
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.greenCrayola),
                            ),
                            onPressed: () {
                              controller.nameController.text = data['name'];

                              Get.to(() => UpdateProfileView(
                                    data: data,
                                  ));
                            },
                            child: StringConstants.editProfil.text.red100
                                .fontFamily(FontConstants.semibold)
                                .make()),
                      ),
                      const Divider(),
                      10.heightBox,
                      FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CardLoading(
                              height: 160,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              margin: EdgeInsets.only(bottom: 10),
                            );
                          } else {
                            var countdata = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                HomeButtons(
                                    textColor: ColorConstants.darkCharcoal,
                                    textButton: text[0],
                                    text: countdata[2].toString(),
                                    width: 160,
                                    height: 90,
                                    icon: colourfulIcon[0]),
                                HomeButtons(
                                    textColor: ColorConstants.darkCharcoal,
                                    textButton: text[1],
                                    text: countdata[1].toString(),
                                    width: 160,
                                    height: 90,
                                    icon: colourfulIcon[0]),
                              ],
                            );
                          }
                        },
                      ),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeButtons(
                              color: ColorConstants.lightCyan,
                              textColor: ColorConstants.darkCharcoal,
                              textButton: text[0],
                              text: '${data['total_diet']}',
                              width: 160,
                              height: 90,
                              icon: colourfulIcon[0]),
                          HomeButtons(
                              color: ColorConstants.lightCyan,
                              textColor: ColorConstants.darkCharcoal,
                              textButton: text[1],
                              text: '${data['fav_dietitian_count']}',
                              width: 160,
                              height: 90,
                              icon: colourfulIcon[0]),
                        ],
                      ),*/
                      10.heightBox,
                      const Divider(),
                      10.widthBox,
                      ProfileMenuWidget(
                        text: 'Randevular',
                        icon: LineAwesomeIcons.calendar,
                        onPress: () {
                          Get.to(() => const OrdersView());
                        },
                      ),
                      ProfileMenuWidget(
                        text: 'İstek Listesi',
                        icon: LineAwesomeIcons.heart,
                        onPress: () {
                          Get.to(() => const WishlistView());
                        },
                      ),
                      ProfileMenuWidget(
                          text: 'Mesajlar',
                          icon: LineAwesomeIcons.sms,
                          onPress: () {
                            Get.to(() => const MessagesScreen());
                          }),
                      const Divider(),
                      10.heightBox,
                      ProfileMenuWidget(
                        text: 'Bilgi',
                        icon: LineAwesomeIcons.info,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                          text: 'Çıkış',
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: ColorConstants.red,
                          onPress: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginView());
                          }),
                    ],
                  ),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
