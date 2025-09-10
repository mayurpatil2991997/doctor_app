import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_screen.dart';
import '../blogs/blogs_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  late List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    // Initialize pages once
    pages = [
      HomeScreen(), // Home
      BlogsScreen(), // Blogs (Health Articles)
      PrescriptionScreen(), // Prescription
      ProfileScreen(), // Profile
    ];
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}

// Placeholder screens for other navigation options

class PrescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Prescription',
          style: TextStyle(
            color: Color(0xFF01A69D),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 80,
              color: Color(0xFF01A69D),
            ),
            SizedBox(height: 20),
            Text(
              'Prescription Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2a2a2a),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'View and manage your prescriptions',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

