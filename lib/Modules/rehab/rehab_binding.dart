import 'package:get/get.dart';
import 'rehab_controller.dart';

class RehabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RehabController>(() => RehabController());
  }
}


