import 'package:get/get.dart';

class BmiController extends GetxController {
  final userHeight = 0.0.obs;
  final userWeight = 0.0.obs;
  final bmiResult = 0.0.obs;

  void calculateBmi() {
    double heightInMeter = userHeight.value / 100;
    bmiResult.value = userWeight.value / (heightInMeter * heightInMeter);
  }
}
