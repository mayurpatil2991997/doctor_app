import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../constants/app_const_assets.dart';
import '../../widgets/common_card_widget.dart';
import '../../widgets/common_avatar_widget.dart';
import '../../widgets/common_button_widget.dart';
import '../../widgets/doctor_bottom_navigation_widget.dart';
import '../../Modules/doctor_main_navigation/doctor_main_navigation_controller.dart';
import 'doctor_home_controller.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final DoctorHomeController controller = Get.put(DoctorHomeController());
  final DoctorMainNavigationController navController = Get.find<DoctorMainNavigationController>();

  @override
  void initState() {
    super.initState();
    // Set current index to home (index 0)
    navController.setCurrentIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(12.h),
        child: _buildHeader(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            // Hospital Information Card
            _buildHospitalCard(),
              SizedBox(height: 2.h),
              
              // Admitted Patient Status Card
              _buildAdmittedPatientCard(),
              SizedBox(height: 2.h),
              
              // Appointment Section
              _buildAppointmentSection(),
              SizedBox(height: 2.h),
              
              // Features & Services Section
              _buildFeaturesSection(),
              SizedBox(height: 2.h),
              
              // Upcoming Exercise/Diet Plan Section
              _buildExerciseSection(),
              SizedBox(height: 2.h),
              
              // BMI & Vitals Overview Section
              _buildVitalsSection(),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      bottomNavigationBar: Obx(() => DoctorBottomNavigationWidget(
        currentIndex: navController.selectedBottomNavIndex.value,
        onTap: navController.onBottomNavTap,
      )),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row - User Profile and Name with Location
              Row(
                children: [
                  // User Profile Avatar
                  Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.whiteColor.withOpacity(0.2),
                      border: Border.all(
                        color: AppColor.whiteColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "D",
                        style: AppTextStyle.boldText.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  // User Name and Location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome back, Doctor",
                          style: AppTextStyle.boldText.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.whiteColor,
                          ),
                        ),
                        SizedBox(height: 0.1.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: AppColor.whiteColor.withOpacity(0.8),
                              size: 10.sp,
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Text(
                                "City General Hospital",
                                style: AppTextStyle.mediumText.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.whiteColor.withOpacity(0.8),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Notification Icon with Badge
                  Stack(
                    children: [
                      Container(
                        width: 5.w,
                        height: 5.w,
                        child: SvgPicture.asset(
                          AppAssets.notification,
                          color: AppColor.whiteColor,
                          width: 10,
                          height: 10,
                        ),
                      ),
                      // Notification Badge
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.whiteColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHospitalCard() {
    return CommonCardWidget(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HOSPITAL",
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 12,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City General Hospital",
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "123 Medical Drive, Anytown",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildAdmittedPatientCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admitted Patient",
                style: AppTextStyle.boldText.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.bed,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            "Room 302, West Wing",
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Center(
            child: ElevatedButton.icon(
              onPressed: controller.onViewDetails,
              icon: Icon(Icons.arrow_forward, size: 18),
              label: Text("View Details"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Appointment",
                style: AppTextStyle.boldText.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
              GestureDetector(
                onTap: controller.onViewAllAppointments,
                child: Text(
                  "View All",
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 14,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: AppColor.primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Physiotherapy Session",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "July 15, 2024, 2:00 PM",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.greyColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features & Services",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Obx(() => Column(
            children: [
              // First row - 3 items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: controller.featureServices.take(3).map((service) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.onFeatureServiceTap(service.title!),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: service.color!.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: service.color!.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                service.icon,
                                color: service.color,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              service.title!,
                              style: AppTextStyle.mediumText.copyWith(
                                fontSize: 12,
                                color: AppColor.blackColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Second row - 3 items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: controller.featureServices.skip(3).take(3).map((service) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.onFeatureServiceTap(service.title!),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: service.color!.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: service.color!.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                service.icon,
                                color: service.color,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              service.title!,
                              style: AppTextStyle.mediumText.copyWith(
                                fontSize: 12,
                                color: AppColor.blackColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildExerciseSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Exercise/Diet Plan",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.directions_run,
                    color: AppColor.primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Morning Mobility Routine",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Starts: July 10, 2024",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.greyColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BMI & Vitals Overview",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "BMI",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.greyColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "24.5",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 24,
                          color: AppColor.blackColor,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Healthy",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Blood Pressure",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.greyColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "120/80",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 24,
                          color: AppColor.blackColor,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "mmHg",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 12,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
