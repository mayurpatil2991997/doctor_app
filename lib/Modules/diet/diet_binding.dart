import 'package:get/get.dart';
import 'diet_controller.dart';

class DietBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DietController());
  }
}



