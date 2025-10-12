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
      'icon': Icons.local_hospital_rounded,
    },
    {
      'title': 'Dermatologist',
      'color': Colors.blueAccent,
      'icon': Icons.healing_rounded,
    },
    {
      'title': 'Dentist',
      'color': Colors.greenAccent,
      'icon': Icons.medical_services_rounded,
    },
    {
      'title': 'Cardiologist',
      'color': Colors.orangeAccent,
      'icon': Icons.favorite_rounded,
    },
    {
      'title': 'Neurologist',
      'color': Colors.purpleAccent,
      'icon': Icons.psychology_rounded,
    },
    {
      'title': 'Psychiatrist',
      'color': Colors.tealAccent,
      'icon': Icons.self_improvement_rounded,
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
        preferredSize: Size.fromHeight(12.h),
        child: header(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Column(children: [
              revisitAndConnect(),
              SizedBox(height: 0.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: upcomingAppointment(),
              ),
            ]),
            SizedBox(height: 2.h),
            specializationWidget(),
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.9),
          ],
        ),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(20),
        //   bottomRight: Radius.circular(20),
        // ),
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
                        homeController.getUserInitials(),
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
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          homeController.userName.value,
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
                                homeController.userLocation.value,
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
                    )),
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

  Widget revisitAndConnect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with proper padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Text(
            "My Appointments",
            style: AppTextStyle.boldText.copyWith(
              color: AppColor.blackColor,
              fontSize: 18,
            ),
          ),
        ),
        // Horizontal Scrollable Cards - Full width
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 3.w, right: 1.w),
        itemCount: 2,
        itemBuilder: (context, index) {
          // Doctor cards (match screenshot layout: left image, right details, pill button)
          final doctors = [
            {
              'name': 'Dr. Kiran Doke',
              'specialization': 'Pediatrician',
              'image': 'assets/images/doctor1.jpg',
              'lastAppointment': '12 Jun 2025',
            },
            {
              'name': 'Dr. Rajesh Kumar',
              'specialization': 'Cardiologist',
              'image': 'assets/images/doctor.png',
              'lastAppointment': '08 May 2025',
            },
          ];

          final doctor = doctors[index];

            return GestureDetector(
              onTap: () {
                // Navigate to patient_home when doctor card is tapped
                Get.toNamed('/patient-home');
              },
              child: Container(
                width: 52.w,
                margin: EdgeInsets.only(right: 3.w, top: 1.h, bottom: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(1, 8)),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left: portrait image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          doctor['image']!,
                          width: 15.w,
                          height: 6.8.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      // Right: name, specialization, button
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor['name']!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.boldText.copyWith(
                                          color: AppColor.blackColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(height: 0.4.h),
                                      Text(
                                        doctor['specialization']!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.mediumText.copyWith(
                                          color: AppColor.greyColor,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.2.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 8.sp,
                                  color: AppColor.greyColor,
                                ),
                                SizedBox(width: 1.w),
                                Expanded(
                                  child: Text(
                                    '${doctor['lastAppointment']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.mediumText.copyWith(
                                      color: AppColor.greyColor,
                                      fontSize: 8.5.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.1.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          
        },
      ),
        ),
      ],
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
                                child: doctor.profileImageUrl != null && 
                                        doctor.profileImageUrl!.isNotEmpty &&
                                        doctor.profileImageUrl!.contains('http')
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          doctor.profileImageUrl!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: AppColor.primaryColor.withOpacity(0.1),
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                      : null,
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            print('🖼️ Home doctor image load error: $error');
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
        // Section Title with proper padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
        // Horizontal Scrollable Cards - Full width
        SizedBox(
          height: 18.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 3.w, right: 1.w),
            itemCount: specializationList.length,
            itemBuilder: (context, index) {
              final item = specializationList[index];
              return Container(
                width: 22.w,
                margin: EdgeInsets.only(right: 4.w, top: 0.5.h, bottom: 0.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: _getSpecializationIcon(item['title']),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 22.w,
                      height: 4.h,
                      child: Center(
                        child: Text(
                          item['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semiBoldText.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.blackColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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

  Widget _getSpecializationIcon(String title) {
    switch (title) {
      case 'General Physician':
        return Icon(Icons.local_hospital_rounded, size: 24, color: Colors.white);
      case 'Dermatologist':
        return Icon(Icons.healing_rounded, size: 24, color: Colors.white);
      case 'Dentist':
        return Icon(Icons.medical_services_rounded, size: 24, color: Colors.white);
      case 'Cardiologist':
        return Icon(Icons.favorite_rounded, size: 24, color: Colors.white);
      case 'Neurologist':
        return Icon(Icons.psychology_rounded, size: 24, color: Colors.white);
      case 'Psychiatrist':
        return Icon(Icons.self_improvement_rounded, size: 24, color: Colors.white);
      default:
        return Icon(Icons.medical_services_rounded, size: 24, color: Colors.white);
    }
  }
}
