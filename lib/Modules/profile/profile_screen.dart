import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/profile_model.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (profileController.userProfile.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        
        final profile = profileController.userProfile.value!;
        
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              
              // Profile Info Section
              profileInfoSection(profile),
              
              SizedBox(height: 3.h),
              
              // Menu Options
              menuOptionsSection(),
              
              SizedBox(height: 2.h),
            ],
          ),
        );
      }),
    );
  }

  Widget profileInfoSection(ProfileModel profile) {
    return Column(
      children: [
        // Profile Picture
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.greyColor.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: profile.profileImage != null && profile.profileImage!.isNotEmpty
                  ? Image.asset(
                      profile.profileImage!,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildFallbackAvatar(profile.name ?? "");
                      },
                    )
                  : _buildFallbackAvatar(profile.name ?? ""),
            ),
          ),
        ),
        
        SizedBox(height: 2.h),
        
        // Name
        Text(
          profile.name ?? "",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 24,
          ),
        ),
        
        SizedBox(height: 0.5.h),
        
        // Specialization
        Text(
          profile.specialization ?? "",
          style: AppTextStyle.mediumText.copyWith(
            color: AppColor.blackColor,
            fontSize: 16,
          ),
        ),
        
        SizedBox(height: 0.5.h),
        
        // Email
        Text(
          profile.email ?? "",
          style: AppTextStyle.mediumText.copyWith(
            color: AppColor.blackColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget menuOptionsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          // Personal Details
          menuOptionCard(
            icon: Icons.person_outline,
            title: "Personal Details",
            onTap: () {
              Get.toNamed('/personal-details');
            },
          ),
          
          SizedBox(height: 1.h),
          
          // Health Records
          menuOptionCard(
            icon: Icons.health_and_safety_outlined,
            title: "Health Records",
            onTap: () {
              // No action for now as requested
            },
          ),
          
          SizedBox(height: 1.h),
          
          // My Family
          menuOptionCard(
            icon: Icons.family_restroom_outlined,
            title: "My Family",
            onTap: () {
              Get.toNamed('/family');
            },
          ),
          
          SizedBox(height: 1.h),
          
          // Notification
          menuOptionCard(
            icon: Icons.notifications_outlined,
            title: "Notification",
            onTap: () {
              Get.toNamed('/ipd-services');
            },
          ),
          
          SizedBox(height: 1.h),
          
          // Themes
          menuOptionCard(
            icon: Icons.palette_outlined,
            title: "Themes",
            onTap: () {
              Get.toNamed('/themes');
            },
          ),
          
          SizedBox(height: 1.h),
          
          // Help & Support
          menuOptionCard(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {
              // No action for now as requested
            },
          ),
          
          SizedBox(height: 1.h),
          
          // Log Out
          menuOptionCard(
            icon: Icons.logout_outlined,
            title: "Log Out",
            onTap: () {
              profileController.logout();
            },
          ),
        ],
      ),
    );
  }

  Widget menuOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
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
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColor.blackColor,
          size: 24,
        ),
        title: Text(
          title,
          style: AppTextStyle.mediumText.copyWith(
            color: AppColor.blackColor,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColor.blackColor,
          size: 16,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      ),
    );
  }

  Widget _buildFallbackAvatar(String name) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "U",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
