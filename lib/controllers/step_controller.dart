import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:get/get.dart';

class StepController extends GetxController {
  var currentStep = 0.obs;
  var selectedValue1 = ''.obs;
  var selectedValue2 = ''.obs;
  var selectedValue3 = ''.obs;
  var selectedValue4 = ''.obs;
  var selectedValue5 = ''.obs;
  var lengthController = TextEditingController();
  var weightController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void nextStep() {
    if (currentStep.value < 6) {
      currentStep.value++;
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
