import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Routes/app_routes.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/doctor_model.dart';
import '../../widgets/custom_text_field.dart';
import 'doctors_controller.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final DoctorsController doctorsController = Get.put(DoctorsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Popular Doctors',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            color: AppColor.whiteColor,
            padding: EdgeInsets.all(16),
            child: CustomTextField(
              hintText: 'Search by Doctor Name',
              controller: doctorsController.searchController,
              keyboardType: TextInputType.text,
              focusNode: doctorsController.searchFocusNode,
              onChanged: doctorsController.searchDoctors,
              preFix: Icon(
                Icons.search,
                color: AppColor.greyColor,
              ),
              suFixIcon: Obx(() => doctorsController.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: AppColor.greyColor),
                      onPressed: () => doctorsController.clearSearch(),
                    )
                  : SizedBox.shrink()),
            ),
          ),
          
          // Doctors Found Section
          Container(
            color: AppColor.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorsController.getDoctorsFoundText(),
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    Obx(() => Text(
                      doctorsController.selectedSpecialization.value,
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 16,
                      ),
                    )),
                  ],
                )),
                Icon(
                  Icons.tune,
                  color: AppColor.blackColor.withOpacity(0.7),
                ),
              ],
            ),
          ),
          
          // Specialization Section
          Container(
            color: AppColor.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() => Row(
                      children: [
                        _buildSpecializationChip('General Physician', doctorsController.selectedSpecialization.value == 'General Physician'),
                        SizedBox(width: 8),
                        _buildSpecializationChip('Cardiologist', doctorsController.selectedSpecialization.value == 'Cardiologist'),
                        SizedBox(width: 8),
                        _buildSpecializationChip('Dermatologist', doctorsController.selectedSpecialization.value == 'Dermatologist'),
                        SizedBox(width: 8),
                        _buildSpecializationChip('Pediatrician', doctorsController.selectedSpecialization.value == 'Pediatrician'),
                        SizedBox(width: 8),
                        _buildSpecializationChip('Neurologist', doctorsController.selectedSpecialization.value == 'Neurologist'),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),

          // Doctors List
          Expanded(
            child: Container(
              color: AppColor.whiteColor,
              child: Obx(() {
                if (doctorsController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  );
                } else if (doctorsController.hasError.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Error loading doctors',
                          style: AppTextStyle.boldText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          doctorsController.errorMessage.value,
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.greyColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => doctorsController.retryLoading(),
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
                } else if (doctorsController.filteredDoctorsList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColor.greyColor,
                        ),
                        SizedBox(height: 16),
                        Text(
                          doctorsController.searchQuery.value.isNotEmpty 
                              ? 'No doctors found for "${doctorsController.searchQuery.value}"'
                              : 'No doctors available',
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.greyColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (doctorsController.searchQuery.value.isEmpty) ...[
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => doctorsController.retryLoading(),
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
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: doctorsController.filteredDoctorsList.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorsController.filteredDoctorsList[index];
                      return doctorCard(doctor);
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorCard(DoctorDetails doctor) {
    return GestureDetector(
      onTap: () {
        // Navigate to doctor profile screen
        Get.toNamed(AppRoutes.doctorProfile, arguments: {'doctor': doctor});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
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
            // Doctor Profile Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image with Status Dot
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor.withOpacity(0.1),
                      ),
                      child: doctor.profileImageUrl != null && doctor.profileImageUrl!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                doctor.profileImageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildDoctorAvatar(doctor);
                                },
                              ),
                            )
                          : _buildDoctorAvatar(doctor),
                    ),
                    // Status Dot
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: doctor.doctorStatus == "Active" ? AppColor.viewGreen : AppColor.yellowColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                
                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Dr. ${doctor.firstName ?? ""} ${doctor.lastName ?? ""}",
                              style: AppTextStyle.boldText.copyWith(
                                color: AppColor.blackColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColor.yellowColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "4.5", // Hardcoded rating
                                style: AppTextStyle.mediumText.copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${doctor.specialization ?? "General Physician"} (5 years Exp)", // Dynamic specialization with hardcoded experience
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Divider
            Container(
              height: 1,
              color: AppColor.greyColor.withOpacity(0.3),
            ),
            
            SizedBox(height: 16),
            
            // Availability and Fee Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side - Availability
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.doctorStatus == "Active" ? "Available Now" : "Not Available", // Dynamic status
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.videocam,
                          color: AppColor.viewGreen,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Video Consult", // Hardcoded
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.viewGreen,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                // Right side - Fee
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "₹ 600", // Hardcoded consultation fee
                      style: AppTextStyle.boldText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Consultation Fee", // Hardcoded
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Book Appointment Button
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () => doctorsController.bookAppointment(doctor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                    Icon(
                      Icons.arrow_forward,
                      color: AppColor.whiteColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildDoctorAvatar(DoctorDetails doctor) {
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
          doctor.firstName != null && doctor.firstName!.isNotEmpty
              ? doctor.firstName![0].toUpperCase()
              : "D",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecializationChip(String specialization, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle specialization selection
        doctorsController.selectSpecialization(specialization);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : AppColor.companyUpdateColor1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : AppColor.greyColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          specialization,
          style: AppTextStyle.mediumText.copyWith(
            color: isSelected ? AppColor.whiteColor : AppColor.blackColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
