import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

class DoctorMainNavigationController extends GetxController {
  var selectedBottomNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBottomNavTap(int index) {
    selectedBottomNavIndex.value = index;
    switch (index) {
      case 0:
        // Home
        Get.offAllNamed(AppRoutes.doctorHome);
        break;
      case 1:
        // Prescription - navigate to doctor prescription screen
        Get.offAllNamed(AppRoutes.doctorPrescription);
        break;
      case 2:
        // Connect - navigate to connect screen
        Get.offAllNamed(AppRoutes.connect);
        break;
    }
  }

  void setCurrentIndex(int index) {
    selectedBottomNavIndex.value = index;
  }
}
