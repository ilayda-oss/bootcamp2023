import 'package:diyet_asistanim/controllers/auth_controller.dart';
import 'package:diyet_asistanim/core/constants/firebase_consts.dart';
import 'package:diyet_asistanim/views/home_screen/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/images.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/applogo_widget.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var paswordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                singUpTextWidget(),
                5.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: StringConstants.nameHint,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          hint: StringConstants.surnameHint,
                          controller: surnameController,
                          isPass: false),
                      customTextField(
                          hint: StringConstants.email,
                          controller: emailController,
                          isPass: false),
                      customTextField(
                          hint: StringConstants.password,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          hint: StringConstants.retypePassword,
                          controller: paswordRetypeController,
                          isPass: true),
                      Row(
                        children: [
                          checkboxWidget(),
                          5.widthBox,
                          privacyPolicyTextWidget(),
                        ],
                      ),
                      10.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  ColorConstants.greenCrayola),
                            )
                          : signInButton(
                              context,
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              nameController.text.trim(),
                              surnameController.text.trim(),
                              controller),
                      15.heightBox,
                      haveAccountTextWidget(),
                    ],
                  )
                      .box
                      .color(Colors.transparent)
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 60)
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget singUpTextWidget() {
    return StringConstants.signin.text
        .fontFamily(FontConstants.bold)
        .black
        .size(24)
        .make();
  }

  Widget singUpDescriptionTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: StringConstants.loginDescription.text.black.center.make(),
    );
  }

  Widget checkboxWidget() {
    return Checkbox(
        activeColor: ColorConstants.greenCrayola,
        checkColor: ColorConstants.white,
        value: isCheck,
        onChanged: (newValue) {
          setState(() {
            isCheck = newValue;
          });
        });
  }

  Widget privacyPolicyTextWidget() {
    return Expanded(
      child: RichText(
          text: const TextSpan(children: [
        TextSpan(
            text: StringConstants.termsOfServices,
            style: TextStyle(
              fontFamily: FontConstants.regular,
              color: ColorConstants.greenCrayola,
            )),
        TextSpan(
            text: ' ve ',
            style: TextStyle(
              fontFamily: FontConstants.regular,
              color: ColorConstants.darkCharcoal,
            )),
        TextSpan(
            text: StringConstants.privacyPolicy,
            style: TextStyle(
              fontFamily: FontConstants.regular,
              color: ColorConstants.greenCrayola,
            )),
        TextSpan(
            text: ' kabul ediyorum.',
            style: TextStyle(
              fontFamily: FontConstants.regular,
              color: ColorConstants.darkCharcoal,
            )),
      ])),
    );
  }

  Widget signInButton(
      BuildContext context,
      String emailcontrollerText,
      String passwordControllerText,
      String nameControllerText,
      String surnameControllerText,
      AuthController controller) {
    return CustomButton(
      onPress: () async {
        if (isCheck != false) {
          controller.isLoading(true);
          try {
            await controller
                .signupMethod(
                    context: context,
                    email: emailcontrollerText,
                    password: passwordControllerText)
                .then((value) {
              return controller.storeUserData(
                  email: emailcontrollerText.trim(),
                  password: passwordControllerText.trim(),
                  name: nameControllerText.trim(),
                  surname: surnameControllerText.trim());
            }).then((value) {
              Get.snackbar("Diyet Asistanım", "Başarıyla kayıt olundu",
                  snackPosition: SnackPosition.BOTTOM);
              Get.offAll(() => const HomeScreen());
            });
          } catch (e) {
            auth.signOut();
            Get.snackbar(
                "Diyet Asistanım", "Kayıt işlemi başarısız sonra deneyin",
                snackPosition: SnackPosition.BOTTOM);
            controller.isLoading(false);
          }
        }
      },
      textButton: StringConstants.signin,
      color:
          isCheck == true ? ColorConstants.greenCrayola : ColorConstants.gray,
    ).box.width(context.screenWidth - 50).height(50).make();
  }

  Widget haveAccountTextWidget() {
    return RichText(
        text: const TextSpan(
      children: [
        TextSpan(
          text: StringConstants.alreadyHaveAccont,
          style: TextStyle(
            fontFamily: FontConstants.bold,
            color: ColorConstants.darkCharcoal,
          ),
        ),
        TextSpan(
          text: StringConstants.login,
          style: TextStyle(
            fontFamily: FontConstants.bold,
            color: ColorConstants.red,
          ),
        ),
      ],
    )).onTap(() {
      Get.back();
    });
  }
}
