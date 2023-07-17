import 'package:diyet_asistanim/controllers/chatGPT_controller.dart';
import 'package:diyet_asistanim/core/constants/colors.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/core/constants/images.dart';
import 'package:diyet_asistanim/core/constants/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

class NutritionView extends StatelessWidget {
  final String s1;

  const NutritionView({super.key, required this.s1});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GptController(s1));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(color: ColorConstants.darkCharcoal),
        title: Align(
          alignment: Alignment.centerLeft,
          child: "Diyet programı"
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
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.halfTriangleDot(
                          color: ColorConstants.greenCrayola, size: 100),
                      10.heightBox,
                      "Diyet listeniz hazırlanıyor"
                          .text
                          .fontFamily(FontConstants.semibold)
                          .color(ColorConstants.darkCharcoal)
                          .size(15)
                          .make()
                    ],
                  ),
                )
              : Center(
                  child: ListView.builder(
                    itemCount:
                        controller.chatGptResponse.value?.choices.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            "${controller.chatGptResponse.value?.choices[index].text}"
                                .text
                                .make(),
                      );
                    },
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: "Kaydet".text.make(),
          icon: const Icon(Icons.save_alt_rounded),
          backgroundColor: ColorConstants.greenCrayola,
          onPressed: () {
            controller.updateAiList(
                (controller.chatGptResponse.value?.choices[0].text)!);
            Get.snackbar('Diyet Asistanım', 'Diyetiniz başarıyla kaydedildi');
          }),
    );
  }
}
