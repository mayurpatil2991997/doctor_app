import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../constants/app_const_assets.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor,
              AppColor.primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  AppAssets.splash,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.medical_services,
                      size: 60,
                      color: AppColor.primaryColor,
                    );
                  },
                ),
              ),
            ),
            
            SizedBox(height: 4.h),
            
            // App Name
            Text(
              'Doctor App',
              style: AppTextStyle.boldText.copyWith(
                color: AppColor.whiteColor,
                fontSize: 32,
                letterSpacing: 1.2,
              ),
            ),
            
            SizedBox(height: 1.h),
            
            // App Tagline
            Text(
              'Your Health, Our Priority',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.whiteColor.withOpacity(0.9),
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            
            SizedBox(height: 8.h),
            
            // Loading Indicator
            Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
