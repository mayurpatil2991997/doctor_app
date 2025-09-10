import 'package:get/get.dart';
import 'ipd_services_controller.dart';

class IpdServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IpdServicesController());
  }
}
