import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../constants/app_const_assets.dart';
import '../../widgets/button_widget.dart';
import 'intro_controller.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introController = Get.put(IntroController());
  List<OnboardingModel> onboardingPages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadData();
    });
  }

  void loadData() {
    setState(() {
      onboardingPages = [
        OnboardingModel(
          image: Image.asset(
            AppAssets.introImage1,
            ),
          description: "Book An Appointment",
        ),
        OnboardingModel(
          image: Image.asset(
            AppAssets.introImage4,
          ),
          description: "Find your perfect doctor",
        ),
        OnboardingModel(
          image: Image.asset(
            AppAssets.introImage3,
          ),
          description: "Doctor Consultation",
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: onboardingPages.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            SizedBox(
              height: 70.h,
              child: PageView.builder(
                controller: introController.pageController,
                itemCount: onboardingPages.length,
                onPageChanged: introController.onPageChanged,
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      page.image,
                      SizedBox(height: 6.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.boldText.copyWith(
                            fontSize: 24,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingPages.length, (index) {
                  bool isActive =
                      introController.currentPage.value == index;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColor.primaryColor
                          : AppColor.greyColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              );
            }),
            SizedBox(height: 4.h),
            Obx(() {
              return Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ButtonWidget(
                  text: introController.currentPage.value ==
                      onboardingPages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  textStyle: AppTextStyle.mediumText.copyWith(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                  ),
                  onTap: introController.nextPage,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class OnboardingModel {
  final Widget image;
  final String description;

  OnboardingModel({required this.image, required this.description});
}
