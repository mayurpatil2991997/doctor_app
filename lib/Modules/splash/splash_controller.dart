import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToMain();
  }

  _navigateToMain() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.mainNavigation);
  }
}
