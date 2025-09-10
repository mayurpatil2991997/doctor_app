import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/bottom_navigation_widget.dart';
import 'main_navigation_controller.dart';

class MainNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainNavigationController controller = Get.find<MainNavigationController>();
    
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: controller.pages,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationWidget(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
      )),
    );
  }
}
