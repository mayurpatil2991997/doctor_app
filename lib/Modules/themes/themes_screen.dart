import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'themes_controller.dart';

class ThemesScreen extends StatefulWidget {
  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  final ThemesController themesController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Themes',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            
            // Theme Modes Section
            themeModesSection(),
            
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget themeModesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Theme Modes",
            style: AppTextStyle.boldText.copyWith(
              color: AppColor.blackColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Theme Options Container
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Light Mode Option
                Obx(() => themeOptionTile(
                  title: "Light Mode",
                  isSelected: themesController.isSelected(AppThemeMode.light),
                  onTap: () => themesController.selectTheme(AppThemeMode.light),
                  showDivider: true,
                )),
                
                // Dark Mode Option
                Obx(() => themeOptionTile(
                  title: "Dark Mode",
                  isSelected: themesController.isSelected(AppThemeMode.dark),
                  onTap: () => themesController.selectTheme(AppThemeMode.dark),
                  showDivider: true,
                )),
                
                // System Default Option
                Obx(() => themeOptionTile(
                  title: "System Default",
                  isSelected: themesController.isSelected(AppThemeMode.system),
                  onTap: () => themesController.selectTheme(AppThemeMode.system),
                  showDivider: false,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget themeOptionTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColor.blackColor,
              fontSize: 16,
            ),
          ),
          trailing: Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: (value) => onTap(),
            activeColor: AppColor.primaryColor,
          ),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColor.greyColor.withOpacity(0.3),
            indent: 4.w,
            endIndent: 4.w,
          ),
      ],
    );
  }
}
