import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/doctor_details_model.dart';
import 'doctor_profile_controller.dart';

class DoctorProfileScreen extends StatefulWidget {
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final DoctorProfileController controller = Get.put(DoctorProfileController());

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
          'Doctor Profile',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                SizedBox(height: 2.h),
                Text(
                  'Loading doctor details...',
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.greyColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 2.h),
                Text(
                  'Error loading doctor details',
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  controller.errorMessage.value,
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.greyColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.loadDoctorProfile(),
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
                    SizedBox(width: 2.w),
                    ElevatedButton(
                      onPressed: () => controller.showRawDoctorDetails(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Show Raw Data',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () => controller.showRawTimeSlots(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Show Time Slots',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () => controller.testTimeSlotsWithDifferentDoctors(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Test Different Doctors',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () => controller.showSlotsSummary(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Show Slots Summary',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () => controller.testDifferentDates(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Test Different Dates',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () => controller.refreshSlots(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Refresh Slots',
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        if (controller.doctorProfile.value == null) {
          return Center(
            child: Text(
              'No doctor details available',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.greyColor,
                fontSize: 16,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Doctor Info Section
              SizedBox(height: 2.h),
              doctorInfoSection(),
              SizedBox(height: 2.h),

              // Available Time Section
              availableTimeSection(),
              SizedBox(height: 2.h),

              // Reviews Section
              reviewsSection(),
            ],
          ),
        );
      }),
      bottomNavigationBar: bookAppointmentButton(),
    );
  }

  Widget doctorInfoSection() {
    final doctor = controller.doctorProfile.value!;

    return Column(
      children: [
        // Doctor Basic Info Container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              // Doctor Image - Properly Centered
              Center(
                child: Container(
                  width: 100,
                  height: 100,
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
                    child:
                        doctor.profileImageUrl != null &&
                                doctor.profileImageUrl!.isNotEmpty
                            ? Image.network(
                              doctor.profileImageUrl!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildFallbackDoctorAvatar(doctor);
                              },
                            )
                            : _buildFallbackDoctorAvatar(doctor),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Doctor Name
              Text(
                "Dr. ${doctor.firstName ?? ""} ${doctor.lastName ?? ""}",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),

              // Specialization
              Text(
                doctor.specialization ?? "",
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),

              // Degree
              Text(
                doctor.qualifications?.join(", ") ?? "",
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.blackColor.withOpacity(0.6),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Stats Container (Experience & Rating)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Total Experience
                Column(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: AppColor.blackColor,
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Total Experience",
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${doctor.experienceYears ?? "5"}+ Years",
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                // Divider
                Container(
                  height: 60,
                  width: 1,
                  color: AppColor.greyColor.withOpacity(0.3),
                ),

                // Rating
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 24),
                    SizedBox(height: 8),
                    Text(
                      "Rating",
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      controller.getRatingText(),
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 2.h),

        // Consultation Fee Container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.currency_rupee,
                  color: AppColor.blackColor,
                  size: 18,
                ),
                 Text(
                   "${doctor.consultationFees?.isNotEmpty == true ? doctor.consultationFees!.first.amount?.toInt() ?? 600 : 600}",
                   style: AppTextStyle.boldText.copyWith(
                     color: AppColor.blackColor,
                     fontSize: 18,
                   ),
                 ),
                SizedBox(width: 8),
                Text(
                  "Consultation fee",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget availableTimeSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
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
            Text(
              "Available Time",
              style: AppTextStyle.boldText.copyWith(
                color: AppColor.blackColor,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),

            // Calendar Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: controller.previousMonth,
                  icon: Icon(Icons.arrow_back_ios, size: 18),
                ),
                Obx(
                  () => Text(
                    controller.getMonthYear(),
                    style: AppTextStyle.boldText.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.nextMonth,
                  icon: Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Days Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                      .map(
                        (day) => SizedBox(
                          width: 40,
                          child: Text(
                            day,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.blackColor.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 12),

            // Calendar Dates
            Obx(
              () => Wrap(
                children:
                    controller.calendarDates.map((date) {
                      bool isToday = controller.isToday(date);
                      bool isSelected = controller.isSelected(date);

                      return GestureDetector(
                        onTap: () => controller.selectDate(date),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColor.primaryColor
                                    : isToday
                                    ? AppColor.primaryColor.withOpacity(0.2)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: AppTextStyle.mediumText.copyWith(
                                color:
                                    isSelected
                                        ? AppColor.whiteColor
                                        : AppColor.blackColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 20),

                  // Time Slots
                  Obx(() {
                    if (controller.isLoadingSlots.value) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              CircularProgressIndicator(color: AppColor.primaryColor),
                              SizedBox(height: 10),
                              Text(
                                "Loading time slots...",
                                style: AppTextStyle.mediumText.copyWith(
                                  color: AppColor.greyColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    // Show mock data indicator if no API data
                    bool isUsingMockData = controller.doctorSlots.value == null;

                    return Column(
                      children: [
                        // Mock data indicator
                        if (isUsingMockData)
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info_outline, color: Colors.orange, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  "Sample time slots (API unavailable)",
                                  style: AppTextStyle.mediumText.copyWith(
                                    color: Colors.orange.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Time slots
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children:
                              controller.availableTimeSlots.map((timeSlot) {
                            return GestureDetector(
                              onTap: () => controller.selectTimeSlot(timeSlot),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      timeSlot.isBooked!
                                          ? Colors.grey.withOpacity(0.3)
                                          : timeSlot.isSelected!
                                          ? AppColor.primaryColor
                                          : AppColor.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        timeSlot.isSelected!
                                            ? AppColor.primaryColor
                                            : Colors.transparent,
                                  ),
                                ),
                                child: Text(
                                  "${timeSlot?.time}\n${timeSlot.period}",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.mediumText.copyWith(
                                    color:
                                        timeSlot.isBooked!
                                            ? Colors.grey
                                            : timeSlot.isSelected!
                                            ? AppColor.whiteColor
                                            : AppColor.primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
            }),

            SizedBox(height: 16),

            // View all availability
            GestureDetector(
              onTap: controller.viewAllAvailability,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View all availability",
                    style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.primaryColor,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewsSection() {
    final doctor = controller.doctorProfile.value!;

    return Container(
      color: AppColor.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviews Header Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "What patients are saying",
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Rating Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${doctor.doctorRating?.averageRating ?? 4.9}",
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color:
                                  index <
                                          (doctor.doctorRating?.averageRating ??
                                                  4.9)
                                              .floor()
                                      ? Colors.orange
                                      : Colors.grey,
                              size: 16,
                            ),
                          ),
                        ),
                        Text(
                          "(${doctor.doctorRating?.totalReviews ?? 5} Reviews)",
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "+ Add Review",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Rating Breakdown - Dynamic from API
                ...List.generate(5, (index) {
                  int rating = 5 - index;
                  int count = _getRatingCount(doctor, rating);
                  double percentage = _getRatingPercentage(doctor, rating);
                  
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          "$rating",
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 12),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "$count",
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          rating == 5
                              ? "Excellent"
                              : rating == 4
                              ? "Good"
                              : rating == 3
                              ? "Average"
                              : rating == 2
                              ? "Below Average"
                              : "Poor",
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Individual Reviews
          ...(doctor.reviews ?? [])
              .map((review) => reviewCard(review))
              .toList(),
        ],
      ),
    );
  }

  Widget reviewCard(Reviews review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient Image with fallback
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withOpacity(0.1),
            ),
            child: ClipOval(
              child: _buildFallbackAvatar(review.patientName ?? ""),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.patientName ?? "",
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        SizedBox(width: 2),
                        Text(
                          review.rating?.toString() ?? "5",
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  review.reviewDate ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  review.comments ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.8),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(String name) {
    return Container(
      width: 40,
      height: 40,
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
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackDoctorAvatar(dynamic doctor) {
    return Container(
      width: 100,
      height: 100,
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
          doctor.firstName != null && doctor.firstName!.isNotEmpty
              ? doctor.firstName![0].toUpperCase()
              : "D",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  // Helper method to get rating count for specific rating
  int _getRatingCount(dynamic doctor, int rating) {
    if (doctor.doctorRating == null) return 0;
    
    switch (rating) {
      case 5:
        return doctor.doctorRating.fiveStarCount ?? 0;
      case 4:
        return doctor.doctorRating.fourStarCount ?? 0;
      case 3:
        return doctor.doctorRating.threeStarCount ?? 0;
      case 2:
        return doctor.doctorRating.twoStarCount ?? 0;
      case 1:
        return doctor.doctorRating.oneStarCount ?? 0;
      default:
        return 0;
    }
  }

  // Helper method to get rating percentage for progress bar
  double _getRatingPercentage(dynamic doctor, int rating) {
    if (doctor.doctorRating == null || doctor.doctorRating.totalReviews == null || doctor.doctorRating.totalReviews == 0) {
      return 0.0;
    }
    
    int count = _getRatingCount(doctor, rating);
    int total = doctor.doctorRating.totalReviews;
    
    return count / total;
  }

  Widget bookAppointmentButton() {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppColor.whiteColor,
      child: ElevatedButton(
        onPressed: controller.bookAppointment,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book Appointment',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.whiteColor,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: AppColor.whiteColor, size: 18),
          ],
        ),
      ),
    );
  }
}
