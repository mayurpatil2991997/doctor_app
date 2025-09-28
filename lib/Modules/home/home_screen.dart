import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../Utils/helper_method.dart';
import '../../constants/app_const_assets.dart';
import '../../model/doctor_model.dart';
import '../main_navigation/main_navigation_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();
  DateTime? _lastBackPressed;

  List<Map<String, dynamic>> appointmentData = [
    {
      "image": "assets/images/doctorAppointment.png",
      "title": "Clinic visit",
      "subtitle": "Make an appointment",
      "icon": Icons.add,
    },
    {
      "image": "assets/images/doctorAppointment.png",
      "title": "Quick Consult",
      "subtitle": "Book Video Consultation",
      "icon": Icons.videocam,
    },
    {
      "image": "assets/images/doctorAppointment.png",
      "title": "Clinic visit",
      "subtitle": "Make an appointment",
      "icon": Icons.add,
    },
    {
      "image": "assets/images/doctorAppointment.png",
      "title": "Quick Consult",
      "subtitle": "Book Video Consultation",
      "icon": Icons.videocam,
    },
  ];

  final List<Map<String, dynamic>> specializationList = [
    {
      'title': 'General Physician',
      'color': Colors.redAccent,
    },
    {
      'title': 'Dermatologist',
      'color': Colors.blueAccent,
    },
    {
      'title': 'Dentist',
      'color': Colors.greenAccent,
    },
    {
      'title': 'Cardiologist',
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Neurologist',
      'color': Colors.purpleAccent,
    },
    {
      'title': 'Psychiatrist',
      'color': Colors.tealAccent,
    },
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: SafeArea(
          child: header(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(children: [upcomingAppointment()]),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: specializationWidget(),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: popularDoctorWidget(),
            ),
            SizedBox(height: 10.h), // Add bottom padding for navigation bar
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.all(12),
      color: AppColor.primaryColor,
      height: 15.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(
                  "Chetan Kale",
                  style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 18,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.search, color: AppColor.whiteColor),
              SizedBox(width: 2.w),
              SvgPicture.asset(AppAssets.notification),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Icon(Icons.location_on, color: AppColor.whiteColor),
              Text(
                "Pune",
                style: AppTextStyle.semiBoldText.copyWith(
                  fontSize: 14,
                  color: AppColor.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget upcomingAppointment() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(1, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Upcoming Appointment",
            style: AppTextStyle.boldText.copyWith(
              color: AppColor.primaryColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 2.h),

          // Doctor Info
          Row(
            children: [
              Container(
                width: 20.w,
                height: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage("assets/images/doctor.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Chetan Kale",
                    style: AppTextStyle.boldText.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Pediatrician",
                    style: AppTextStyle.boldText.copyWith(
                      color: AppColor.blackColor.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Date and Time Row
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 20),
              SizedBox(width: 3.w),
              Text(
                "Today, 2:30 AM",
                style: AppTextStyle.mediumText.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4 patients remaining",
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 13,
                  color: AppColor.blackColor,
                ),
              ),
              Text(
                "You are 4th in line",
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 13,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.25,
              backgroundColor: Colors.grey.withOpacity(0.5),
              color: Colors.blue,
              minHeight: 1.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget popularDoctorWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Doctor",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                    Get.toNamed('/doctors');
                },
                child: Text(
                  "See all",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          if (homeController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          } else if (homeController.hasError.value) {
            return Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Error loading doctors',
                    style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => homeController.retryLoading(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (homeController.top3Doctors.isEmpty) {
            return Center(
              child: Text(
                'No doctors available',
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.greyColor,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: homeController.top3Doctors.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final doctor = homeController.top3Doctors[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(1, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor.primaryColor.withOpacity(0.1),
                                ),
                                child: doctor.profileImageUrl != null && doctor.profileImageUrl!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          doctor.profileImageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return _buildDoctorImagePlaceholder(doctor);
                                          },
                                        ),
                                      )
                                    : _buildDoctorImagePlaceholder(doctor),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. ${doctor.firstName ?? ""} ${doctor.lastName ?? ""}",
                                        style: AppTextStyle.boldText.copyWith(
                                          color: AppColor.blackColor,
                                          fontSize: 18,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        doctor.specialization ?? "General Physician",
                                        style: AppTextStyle.boldText.copyWith(
                                          color: AppColor.blackColor.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        doctor.qualifications ?? "10 Year Experience",
                                        style: AppTextStyle.boldText.copyWith(
                                          color: AppColor.blackColor.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColor.blackColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "Pimpari - chinchwad", // Hardcoded location
                                              style: AppTextStyle.boldText.copyWith(
                                                color: AppColor.blackColor.withOpacity(0.5),
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColor.companyUpdateColor2,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.star, color: AppColor.yellowColor),
                                            SizedBox(width: 2.2),
                                            Text(
                                              "4.5", // Hardcoded rating
                                              style: AppTextStyle.boldText.copyWith(
                                                color: AppColor.blackColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
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
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              },
            );
          }
        }),
      ],
    );
  }

  Widget specializationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Browse By Specialization",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/medicines');
                },
                child: Text(
                  "See all",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 18.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specializationList.length,
            itemBuilder: (context, index) {
              final item = specializationList[index];
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 25.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.heart,
                            height: 6.h,
                            width: 12.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: 25.w,
                        child: Center(
                          child: Text(
                            item['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: AppTextStyle.semiBoldText.copyWith(
                              fontSize: 14,
                              color: AppColor.blackColor
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorImagePlaceholder(DoctorDetails doctor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          doctor.firstName != null && doctor.firstName!.isNotEmpty
              ? doctor.firstName![0].toUpperCase()
              : "D",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
