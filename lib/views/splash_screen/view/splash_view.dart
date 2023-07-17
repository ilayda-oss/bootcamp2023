import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/applogo_widget.dart';
import 'package:diyet_asistanim/views/auth_view/view/login_view.dart';
import 'package:diyet_asistanim/views/home_screen/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //Get.to(() => const LoginView());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginView());
        } else {
          Get.to(() => const HomeScreen());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            300.heightBox,
            applogoBlackWidget(),
            10.heightBox,
            appNameTextWidget(),
            5.heightBox,
            StringConstants.appversion.text.black.make(),
            const Spacer(),
            StringConstants.credits.text.black
                .fontFamily(FontConstants.semibold)
                .make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }

  Widget appNameTextWidget() {
    return StringConstants.appName.text
        .fontFamily(FontConstants.bold)
        .size(25)
        .black
        .make();
  }
}
