import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Wait for 3 seconds to show splash screen
    await Future.delayed(Duration(seconds: 3));
    
    // Navigate to main navigation screen
    Get.offAllNamed(AppRoutes.mainNavigation);
  }
}
