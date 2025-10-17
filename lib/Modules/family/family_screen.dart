import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../constants/app_const_assets.dart';
import 'family_controller.dart';

class FamilyScreen extends StatefulWidget {
  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  final FamilyController familyController = Get.put(FamilyController());

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
          'My Family',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (familyController.hasFamilyMembers) {
          return familyMembersList();
        } else {
          return emptyFamilyState();
        }
      }),
    );
  }

  Widget emptyFamilyState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          
          // Family Illustration
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3F2FD), // Light blue background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: _buildFamilyIllustration(),
              ),
            ),
          ),
          
          SizedBox(height: 4.h),
          
          // Main Text
          Text(
            "Track your family health",
            style: AppTextStyle.boldText.copyWith(
              color: AppColor.blackColor,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 2.h),
          
          // Subtitle Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "Add records & maintain family medical history",
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.blackColor.withOpacity(0.7),
                fontSize: 16,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Add Family Member Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => familyController.addFamilyMember(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Family Member',
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget familyMembersList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.h),
          
          // Information Banner
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1), // Light teal background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Family members you add can view and manage your health records',
                    style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 3.h),
          
          // Family Members Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Family Members',
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'People who can access your health data',
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 2.h),
          
          // Add Family Member Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => familyController.addFamilyMember(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add Family Member',
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SizedBox(height: 2.h),
          
          // Family Members List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: familyController.familyMembersList.length,
            itemBuilder: (context, index) {
              final member = familyController.familyMembersList[index];
              return familyMemberCard(member);
            },
          ),
          
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget familyMemberCard(dynamic member) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
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
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withOpacity(0.1),
            ),
            child: ClipOval(
              child: member.profileImage != null && member.profileImage!.isNotEmpty
                  ? Image.asset(
                      member.profileImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildMemberAvatar(member.name ?? "");
                      },
                    )
                  : _buildMemberAvatar(member.name ?? ""),
            ),
          ),
          
          SizedBox(width: 4.w),
          
          // Member Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name ?? "",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  member.relationship ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            children: [
              IconButton(
                onPressed: () => familyController.editFamilyMember(member),
                icon: Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () => familyController.deleteFamilyMember(member),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyIllustration() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE3F2FD), // Light blue background
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.familyImage,
          // width: 160,
          // height: 160,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.family_restroom,
                size: 80,
                color: AppColor.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMemberAvatar(String name) {
    return Container(
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
          name.isNotEmpty ? name[0].toUpperCase() : "F",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }


  void _showSharedInformationPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shared Information',
                    style: AppTextStyle.boldText.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.greyColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColor.blackColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 2.h),
              
              // Description
              Text(
                'Control what health information your family members can access',
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.blackColor.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Shared Information Items
              Obx(() => Column(
                children: [
                  _buildPopupSharedInfoItem(
                    icon: Icons.warning_amber_outlined,
                    title: 'Allergies',
                    isEnabled: familyController.allergiesEnabled.value,
                    onChanged: (value) => familyController.allergiesEnabled.value = value,
                  ),
                  SizedBox(height: 2.h),
                  _buildPopupSharedInfoItem(
                    icon: Icons.medical_services_outlined,
                    title: 'Health Records',
                    isEnabled: familyController.healthRecordsEnabled.value,
                    onChanged: (value) => familyController.healthRecordsEnabled.value = value,
                  ),
                  SizedBox(height: 2.h),
                  _buildPopupSharedInfoItem(
                    icon: Icons.medication_outlined,
                    title: 'Medications',
                    isEnabled: familyController.medicationsEnabled.value,
                    onChanged: (value) => familyController.medicationsEnabled.value = value,
                  ),
                  SizedBox(height: 2.h),
                  _buildPopupSharedInfoItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Appointments',
                    isEnabled: familyController.appointmentsEnabled.value,
                    onChanged: (value) => familyController.appointmentsEnabled.value = value,
                  ),
                  SizedBox(height: 2.h),
                  _buildPopupSharedInfoItem(
                    icon: Icons.science_outlined,
                    title: 'Test Results',
                    isEnabled: familyController.testResultsEnabled.value,
                    onChanged: (value) => familyController.testResultsEnabled.value = value,
                  ),
                ],
              )),
              
              SizedBox(height: 3.h),
              
              // Save Button
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      "Settings Updated",
                      "Shared information preferences have been saved",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Save Settings',
                    style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupSharedInfoItem({
    required IconData icon,
    required String title,
    required bool isEnabled,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.blackColor,
          size: 24,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColor.blackColor,
              fontSize: 16,
            ),
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: onChanged,
          activeColor: AppColor.primaryColor,
          activeTrackColor: AppColor.primaryColor.withOpacity(0.3),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }
}

