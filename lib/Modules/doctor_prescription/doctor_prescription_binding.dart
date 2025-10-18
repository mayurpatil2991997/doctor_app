import 'package:get/get.dart';
import 'doctor_prescription_controller.dart';
import '../doctor_main_navigation/doctor_main_navigation_controller.dart';

class DoctorPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorMainNavigationController());
    Get.lazyPut(() => DoctorPrescriptionController());
  }
}
