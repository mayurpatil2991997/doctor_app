import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/personal_details_model.dart';
import 'personal_details_controller.dart';

class PersonalDetailsScreen extends StatefulWidget {
  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final PersonalDetailsController personalDetailsController = Get.put(PersonalDetailsController());

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
          'Personal Details',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (personalDetailsController.personalDetails.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        
        final details = personalDetailsController.personalDetails.value!;
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(3.w),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              
              // Basic Information Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Basic Information',
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              
              // Basic Information Section
              basicInformationSection(details),
              
              SizedBox(height: 3.h),
              
              // Professional Details Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Professional Details',
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              
              // Professional Details Section
              professionalDetailsSection(details),
            ],
          ),
        );
      }),
    );
  }

  Widget basicInformationSection(PersonalDetailsModel details) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          detailRow('Name', details.name ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Date of Birth
          detailRow('Date of birth', details.dateOfBirth ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Email
          detailRow('Email', details.email ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Phone Number
          detailRow('Phone Number', details.phoneNumber ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Address
          detailRow('Address', details.address ?? ""),
        ],
      ),
    );
  }

  Widget professionalDetailsSection(PersonalDetailsModel details) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medical License Number
          detailRow('Medical License Number', details.medicalLicenseNumber ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Specialization
          detailRow('Specialization', details.specialization ?? ""),
          SizedBox(height: 2.h),
          Divider(height: 1.h),
          SizedBox(height: 2.h),
          
          // Years of Experience
          detailRow('Years of Experiences', details.yearsOfExperience ?? ""),
        ],
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.mediumText.copyWith(
            color: AppColor.blackColor.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.mediumText.copyWith(
            color: AppColor.blackColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
