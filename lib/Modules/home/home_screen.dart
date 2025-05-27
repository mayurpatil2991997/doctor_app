import 'package:doctor_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../Utils/app_validator.dart';
import '../../constants/app_const_assets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../intro/intro_controller.dart';
import 'home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();

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
          child: header(), // Your custom header
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
            appointmentOptions(),
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

  Widget appointmentOptions() {
    return SizedBox(
      height: 28.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appointmentData.length,
        itemBuilder: (context, index) {
          final data = appointmentData[index];
          return SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 20.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(data['image'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 18,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.tealAccent.shade100,
                        child: Icon(
                          data['icon'],
                          size: 16,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data['subtitle'],
                              style: AppTextStyle.boldText.copyWith(
                                fontSize: 12,
                                color: AppColor.blackColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: AppColor.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
              Text(
                "See all",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                              image: DecorationImage(
                                image: AssetImage("assets/images/doctor.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. Chetan Kale",
                                  style: AppTextStyle.boldText.copyWith(
                                    color: AppColor.blackColor,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  "Pediatrician",
                                  style: AppTextStyle.boldText.copyWith(
                                    color: AppColor.blackColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  "10 Year Experience",
                                  style: AppTextStyle.boldText.copyWith(
                                    color: AppColor.blackColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
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
                                    Text(
                                      "Pimpari - chinchwad",
                                      style: AppTextStyle.boldText.copyWith(
                                        color: AppColor.blackColor.withOpacity(
                                          0.5,
                                        ),
                                        fontSize: 14,
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
                                    children: [
                                      Icon(Icons.star, color: Colors.orange),
                                      SizedBox(width: 2.2),
                                      Text(
                                        "4.5",
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
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            );
          },
        ),
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
              Text(
                "See all",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 14,
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
}
