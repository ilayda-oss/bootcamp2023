// ignore_for_file: file_names

import 'package:diyet_asistanim/controllers/auth_controller.dart';
import 'package:diyet_asistanim/controllers/home_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/views/assistant_view/view/assistan_screen.dart';
import 'package:diyet_asistanim/views/auth_view/view/login_view.dart';
import 'package:diyet_asistanim/views/chat_view/view/messaging_screen.dart';
import 'package:diyet_asistanim/views/orders_screen/view/orders_view.dart';
import 'package:diyet_asistanim/views/wishlist_screen/view/wishlist_view.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff6F7FA1), Color(0xff536184)]),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: "${controller.username} ${controller.surname}"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.bold)
                  .make(),
              accountEmail: controller.email.text.size(13).make(),
              currentAccountPicture: CircleAvatar(
                radius: 35,
                child: ClipOval(
                  child: controller.img == ''
                      ? Image.asset(IconConstants.user.toPng)
                      : Image.network(controller.img),
                ),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff6F7FA1), Color(0xff536184)]),
              ),
            ),
            ListTile(
              leading: const Icon(
                LineAwesomeIcons.calendar,
                color: Colors.white,
                size: 22,
              ),
              title: "Randevular"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {
                Get.to(() => const OrdersView());
              },
            ),
            ListTile(
              leading: const Icon(
                LineAwesomeIcons.heart_1,
                color: Colors.white,
                size: 22,
              ),
              title: "İstek Listesi"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {
                Get.to(() => const WishlistView());
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.sms,
                  color: Colors.white, size: 22),
              title: "Mesajlar"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {
                Get.to(() => const MessagesScreen());
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.list_ol,
                  color: Colors.white, size: 22),
              title: "Diyet Listesi"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                LineAwesomeIcons.robot,
                color: Colors.white,
                size: 22,
              ),
              title: "Yapay Zeka Asistanı"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {
                Get.to(() => const AssistanScreen());
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                LineAwesomeIcons.info,
                color: Colors.white,
                size: 22,
              ),
              title: "Bilgi"
                  .text
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .white
                  .make(),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                LineAwesomeIcons.alternate_sign_out,
                color: Colors.red,
                size: 22,
              ),
              title: "Çıkış"
                  .text
                  .color(ColorConstants.red)
                  .size(16)
                  .fontFamily(FontConstants.regular)
                  .make(),
              onTap: () async {
                await Get.put(AuthController()).signoutMethod(context);
                Get.offAll(() => const LoginView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
