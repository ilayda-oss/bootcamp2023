import 'package:diyet_asistanim/controllers/home_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/exit_dialog.dart';
import 'package:diyet_asistanim/views/category_screen/view/category_view.dart';
import 'package:diyet_asistanim/views/home_screen/view/home_view.dart';
import 'package:diyet_asistanim/views/orders_screen/view/orders_view.dart';
import 'package:diyet_asistanim/views/profile_screen/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      const BottomNavigationBarItem(
        icon: Icon(LineAwesomeIcons.home, size: 25),
        label: StringConstants.home,
      ),
      const BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.fruit_apple, size: 25),
          label: StringConstants.fav),
      const BottomNavigationBarItem(
          icon: Icon(
            LineAwesomeIcons.book,
            size: 25,
          ),
          label: StringConstants.book),
      const BottomNavigationBarItem(
          icon: Icon(
            LineAwesomeIcons.user,
            size: 25,
          ),
          label: StringConstants.account),
    ];

    var navBody = [
      const HomeView(),
      const CategoryView(),
      const OrdersView(),
      const ProfileView(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: ColorConstants.greenCrayola,
            unselectedItemColor: ColorConstants.darkBlueGray,
            unselectedLabelStyle:
                const TextStyle(fontFamily: FontConstants.medium),
            selectedLabelStyle:
                const TextStyle(fontFamily: FontConstants.semibold),
            items: navbarItem,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorConstants.white,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
