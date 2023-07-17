import 'package:diyet_asistanim/controllers/step_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/lists.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:diyet_asistanim/views/nutrition_view/view/nutrition_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AssistanScreen extends StatelessWidget {
  const AssistanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StepController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        title: Align(
          alignment: Alignment.centerLeft,
          child: "Yapay zeka asistanı"
              .text
              .fontFamily(FontConstants.medium)
              .color(ColorConstants.darkCharcoal)
              .size(18)
              .make(),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(IconConstants.background.toPng),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        IconConstants.people.toPng,
                        width: 100,
                      ),
                      10.widthBox,
                      Flexible(
                        child:
                            "Size uygun beslenme programı oluşturabilmemiz için bilgilenizi girin"
                                .text
                                .fontFamily(FontConstants.light)
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                      ),
                    ],
                  ),
                  Obx(
                    () => Theme(
                      data: ThemeData(
                          colorScheme: ColorScheme.fromSwatch()
                              .copyWith(primary: ColorConstants.greenCrayola)),
                      child: Stepper(
                        currentStep: controller.currentStep.value,
                        onStepContinue: controller.nextStep,
                        onStepCancel: controller.prevStep,
                        onStepTapped: (value) {
                          controller.currentStep.value = value;
                        },
                        controlsBuilder: (context, details,
                            {onStepContinue, onStepCancel}) {
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (controller.currentStep.value != 6) {
                                        controller.nextStep();
                                      } else {
                                        Get.to(() => NutritionView(
                                            s1: "Kişinin yaşı: ${controller.selectedValue1}, cinsiyeti: ${controller.selectedValue2}, boyu: ${controller.lengthController.text}cm, kilosu: ${controller.weightController.text}kg, hastalığı: ${controller.selectedValue3}, günlük aktivasyon seviyesi: ${controller.selectedValue4}, hedefi: ${controller.selectedValue5}. Bu kişiye sadece 1 günlük 1 sabah, 1 akşam, 1 öğle yemeğini gramlarıyla beraber liste şeklinde hazırla."));
                                      }
                                    },
                                    child: "Devam".text.make()),
                              ),
                              16.widthBox,
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: controller.prevStep,
                                      child: "Geri".text.make()))
                            ],
                          );
                        },
                        steps: [
                          Step(
                            title: "Yaşınızı giriniz"
                                .text
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                            isActive: controller.currentStep.value >= 0,
                            content: buildDropdownButtonFormField(
                                'Seçiniz', controller.selectedValue1, age),
                          ),
                          Step(
                            title: "Cinsiyetinizi giriniz"
                                .text
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                            isActive: controller.currentStep.value >= 1,
                            content: buildDropdownButtonFormField('Seçiniz',
                                controller.selectedValue2, ['Kadın', 'Erkek']),
                          ),
                          Step(
                              title: "Boyunuzu (cm) giriniz"
                                  .text
                                  .color(ColorConstants.darkCharcoal)
                                  .size(15)
                                  .make(),
                              isActive: controller.currentStep.value >= 2,
                              content: TextField(
                                controller: controller.lengthController,
                              )),
                          Step(
                              title: "Kilonuzu (kg) giriniz"
                                  .text
                                  .color(ColorConstants.darkCharcoal)
                                  .size(15)
                                  .make(),
                              isActive: controller.currentStep.value >= 3,
                              content: TextField(
                                controller: controller.weightController,
                              )),
                          Step(
                            title: "Hastalığınız varsa giriniz"
                                .text
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                            isActive: controller.currentStep.value >= 4,
                            content: buildDropdownButtonFormField(
                                'Seçiniz', controller.selectedValue3, [
                              'Hastalığım yok',
                              'Diyabet',
                              'Kanser',
                              'Kalp Hastalığı',
                              'Hipertansiyon',
                              'Obezite'
                            ]),
                          ),
                          Step(
                            title: "Günlük aktivite seviyenici seçiniz"
                                .text
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                            isActive: controller.currentStep.value >= 5,
                            content: buildDropdownButtonFormField(
                                'Seçiniz', controller.selectedValue4, [
                              'Hareketsiz',
                              'Biraz aktif',
                              'Hareketsiz iş, haftada 3-4 gün antreman',
                              'Ortalama iş, haftada 5-7 gün antrenman',
                              'Yogun iş, profesyonel seviyede antrenman'
                            ]),
                          ),
                          Step(
                            title: "Hedefinizi seçiniz"
                                .text
                                .color(ColorConstants.darkCharcoal)
                                .size(15)
                                .make(),
                            isActive: controller.currentStep.value >= 6,
                            content: buildDropdownButtonFormField(
                                'Seçiniz',
                                controller.selectedValue5,
                                ['Kilo vermek', 'Kilo almak', 'Kilo korumak']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButtonFormField(
      String labelText, RxString selectedValue, List<String> value) {
    return Obx(
      () => DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(labelText: labelText),
        value: selectedValue.value.isEmpty ? null : selectedValue.value,
        onChanged: (String? newValue) {
          selectedValue.value = newValue!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen bir değer seçin';
          }
          return null;
        },
        items: value.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
