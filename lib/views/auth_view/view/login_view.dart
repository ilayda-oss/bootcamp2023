import 'package:diyet_asistanim/controllers/auth_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/applogo_widget.dart';
import 'package:diyet_asistanim/views/auth_view/view/signup_view.dart';
import 'package:diyet_asistanim/views/home_screen/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/lists.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                applogoWidget(),
                5.heightBox,
                welcomeTextWidget(),
                5.heightBox,
                descriptionTextWidget(),
                20.heightBox,
                bodyWidget(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context, AuthController controller) {
    return Obx(
      () => Column(
        children: [
          customTextField(
              hint: StringConstants.email,
              isPass: false,
              controller: controller.emailController),
          customTextField(
              hint: StringConstants.password,
              isPass: true,
              controller: controller.passwordController),
          5.heightBox,
          controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(ColorConstants.greenCrayola),
                )
              : loginButton(context, controller),
          rememberMeButton(),
          socialMediaButtons(),
          20.heightBox,
          singInTextButton(context),
        ],
      )
          .box
          .padding(const EdgeInsets.all(16))
          .width(context.screenWidth - 50)
          .make(),
    );
  }

  Widget loginButton(BuildContext context, AuthController controller) {
    return CustomButton(
            key: key,
            onPress: () async {
              controller.isLoading(true);

              await controller.loginMethod(context: context).then((value) {
                if (value != null) {
                  Get.snackbar("Diyet Asistanım", "Başarıyla giriş yapıldı",
                      snackPosition: SnackPosition.BOTTOM);
                  Get.offAll(() => const HomeScreen());
                } else {
                  controller.isLoading(false);
                }
              });
            },
            color: ColorConstants.greenCrayola,
            textButton: StringConstants.login)
        .box
        .width(context.screenWidth - 50)
        .height(50)
        .make();
  }

  Widget rememberMeButton() {
    return TextButton(
        onPressed: () {},
        child: StringConstants.forgetpassword.text.green500
            .fontFamily(FontConstants.regular)
            .size(14)
            .make());
  }

  Widget socialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: ColorConstants.lightGrey,
                  radius: 25,
                  child: Image.asset(socialIconList[index].toPng, width: 30),
                ),
              )),
    );
  }

  Widget singInTextButton(BuildContext context) {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
        text: StringConstants.signin,
        style: TextStyle(
            fontFamily: FontConstants.bold, color: ColorConstants.darkCharcoal),
      )
    ])).onTap(() {
      Get.to(() => const SignupView());
    });
  }

  Widget welcomeTextWidget() {
    return StringConstants.welcome.text
        .fontFamily(FontConstants.bold)
        .black
        .size(24)
        .make();
  }

  Widget descriptionTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: StringConstants.loginDescription.text.black.center.make(),
    );
  }
}
