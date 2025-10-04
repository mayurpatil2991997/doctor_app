import 'package:get/get.dart';
import 'patient_home_controller.dart';

class PatientHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PatientHomeController());
  }
}
