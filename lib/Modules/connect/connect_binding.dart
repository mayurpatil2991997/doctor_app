import 'package:get/get.dart';
import 'connect_controller.dart';
import '../doctor_main_navigation/doctor_main_navigation_controller.dart';

class ConnectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorMainNavigationController());
    Get.lazyPut(() => ConnectController());
  }
}
