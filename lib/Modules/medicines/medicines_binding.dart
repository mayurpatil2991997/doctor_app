import 'package:get/get.dart';
import 'medicines_controller.dart';

class MedicinesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicinesController());
  }
}
