import 'package:get/get.dart';

import 'fitness_assessment_controller.dart';

class FitnessAssessmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FitnessAssessmentController());
  }
}
