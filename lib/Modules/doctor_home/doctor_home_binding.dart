import 'package:get/get.dart';
import 'doctor_home_controller.dart';

class DoctorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorHomeController());
  }
}
