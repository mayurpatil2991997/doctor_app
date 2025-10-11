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
import 'patient_home_controller.dart';

class PatientHomeScreen extends StatefulWidget {
  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final PatientHomeController controller = Get.put(PatientHomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              _buildHeader(),
              SizedBox(height: 2.h),
              
              // Hospital Information Card
              _buildHospitalCard(),
              SizedBox(height: 2.h),
              
              // Doctor Information Card
              _buildDoctorCard(),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 3.h,
                backgroundImage: AssetImage("assets/images/doctor.png"),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back,",
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 14,
                      color: AppColor.greyColor,
                    ),
                  ),
                  Text(
                    "Patient",
                    style: AppTextStyle.boldText.copyWith(
                      fontSize: 18,
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              SvgPicture.asset(
                AppAssets.notification,
                height: 6.w,
                width: 6.w,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildHospitalCard() {
    return CommonCardWidget(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.all(2.w),
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
    );
  }

  Widget _buildDoctorCard() {
    return CommonCardWidget(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "YOUR DOCTOR",
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
                      "Dr. Amelia Harper",
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "Physiotherapist",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 4.h,
                backgroundImage: AssetImage("assets/images/doctor.png"),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.onCallDoctor,
                  icon: Icon(Icons.phone, size: 18),
                  label: Text("Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.onMessageDoctor,
                  icon: Icon(Icons.message, size: 18),
                  label: Text("Message"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: AppColor.blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                  ),
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
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.featureServices.map((service) {
              return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.onFeatureServiceTap(service.title!),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      padding: EdgeInsets.all(4.w),
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
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            service.title!,
                            style: AppTextStyle.mediumText.copyWith(
                              fontSize: 14,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              );
            }).toList(),
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
