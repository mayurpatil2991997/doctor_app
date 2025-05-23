import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

class IntroController extends GetxController {
  final emailController = TextEditingController();

  var currentPage = 0.obs;
  var pageController = PageController();

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Get.toNamed(AppRoutes.login);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

}
