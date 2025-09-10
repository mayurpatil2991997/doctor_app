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


          // Doctors List
          Expanded(
            child: Container(
              color: AppColor.whiteColor,
              child: Obx(() => ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: doctorsController.filteredDoctorsList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorsController.filteredDoctorsList[index];
                  return doctorCard(doctor);
                },
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorCard(DoctorModel doctor) {
    return GestureDetector(
      onTap: () {
        // Navigate to doctor profile screen
        Get.toNamed(AppRoutes.doctorProfile, arguments: {'doctor': doctor});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(doctor.image ?? "assets/images/doctor1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
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
                        Text(
                          doctor.name ?? "",
                          style: AppTextStyle.boldText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              doctor.rating.toString(),
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
                      doctor.specialization ?? "",
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Availability Status

                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Text(
                doctor.availabilityStatus ?? "",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                "₹${doctor.consultationFee}",
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),

          // Video Consult Badge
          if (doctor.isVideoConsult!)
            Row(
              children: [
                Icon(
                  Icons.videocam,
                  color: Colors.green,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "Video Consult",
                  style: AppTextStyle.mediumText.copyWith(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                Text(
                  "Consultation Fee",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor.withOpacity(0.6),
                    fontSize: 12,
                  ),
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
}
