import 'package:get/get.dart';
import 'themes_controller.dart';

class ThemesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemesController());
  }
}
