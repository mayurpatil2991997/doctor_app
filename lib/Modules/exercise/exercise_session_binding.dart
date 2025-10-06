import 'package:get/get.dart';
import 'exercise_session_controller.dart';

class ExerciseSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseSessionController>(() => ExerciseSessionController());
  }
}

