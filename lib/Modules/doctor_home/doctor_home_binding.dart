import 'package:get/get.dart';
import 'doctor_home_controller.dart';
import '../doctor_main_navigation/doctor_main_navigation_controller.dart';

class DoctorHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorMainNavigationController());
    Get.lazyPut(() => DoctorHomeController());
  }
}
