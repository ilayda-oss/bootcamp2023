import 'dart:io';

import 'package:diyet_asistanim/controllers/profile_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/strings.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/core/widgets/custom_button.dart';
import 'package:diyet_asistanim/core/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileView extends StatelessWidget {
  final dynamic data;

  const UpdateProfileView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: ColorConstants.darkCharcoal,
            )),
        title: StringConstants.myProfile.text
            .color(ColorConstants.darkCharcoal)
            .fontFamily(FontConstants.medium)
            .make(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: data['imageUrl'] == '' &&
                                      controller.profileImgPath.isEmpty
                                  ? Image.asset(
                                      IconConstants.user.toPng,
                                      fit: BoxFit.cover,
                                    )
                                  : data['imageUrl'] != '' &&
                                          controller.profileImgPath.isEmpty
                                      ? Image.network(
                                          data['imageUrl'],
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(controller.profileImgPath.value),
                                          fit: BoxFit.cover,
                                        )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:
                                  ColorConstants.greenCrayola.withOpacity(0.8),
                            ),
                            child: const Icon(
                              LineAwesomeIcons.camera,
                              color: ColorConstants.white,
                              size: 20,
                            ),
                          ).onTap(() {
                            controller.changeImage(context);
                          }),
                        ),
                      ],
                    ),
                    50.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: StringConstants.nameHint.text
                            .fontFamily(FontConstants.semibold)
                            .color(ColorConstants.darkCharcoal)
                            .size(15)
                            .make(),
                      ),
                    ),
                    customTextField(
                        controller: controller.nameController,
                        hint: StringConstants.nameHint,
                        isPass: false),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: StringConstants.password.text
                            .fontFamily(FontConstants.semibold)
                            .color(ColorConstants.darkCharcoal)
                            .size(15)
                            .make(),
                      ),
                    ),
                    customTextField(
                        controller: controller.oldpasswordController,
                        hint: StringConstants.passwordHint,
                        isPass: true),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: StringConstants.newPassword.text
                            .fontFamily(FontConstants.semibold)
                            .color(ColorConstants.darkCharcoal)
                            .size(15)
                            .make(),
                      ),
                    ),
                    customTextField(
                        controller: controller.newpasswordController,
                        hint: StringConstants.passwordHint,
                        isPass: true),
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                ColorConstants.greenCrayola),
                          )
                        : CustomButton(
                            onPress: () async {
                              controller.isLoading(true);

                              if (controller.profileImgPath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImgageLink = data['imageUrl'];
                              }

                              if (data['password'] ==
                                  controller.oldpasswordController.text
                                      .trim()) {
                                await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller
                                      .oldpasswordController.text
                                      .trim(),
                                  newpassword: controller
                                      .newpasswordController.text
                                      .trim(),
                                );

                                await controller.updateProfile(
                                  imgUrl: controller.profileImgageLink,
                                  name: controller.nameController.text.trim(),
                                  password: controller
                                      .newpasswordController.text
                                      .trim(),
                                );
                                Get.snackbar('Diyet Asistanım', 'Güncellendi');
                              } else {
                                Get.snackbar('Diyet Asistanım',
                                    'Bilgilerinizi tekrar giriniz');
                                controller.isLoading(false);
                              }
                            },
                            textButton: StringConstants.save,
                            color: ColorConstants.greenCrayola),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
