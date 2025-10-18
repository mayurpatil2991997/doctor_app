import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/medicine_model.dart';
import '../../widgets/doctor_bottom_navigation_widget.dart';
import '../../Modules/doctor_main_navigation/doctor_main_navigation_controller.dart';
import 'doctor_prescription_controller.dart';

class DoctorPrescriptionScreen extends StatefulWidget {
  @override
  State<DoctorPrescriptionScreen> createState() => _DoctorPrescriptionScreenState();
}

class _DoctorPrescriptionScreenState extends State<DoctorPrescriptionScreen> {
  final DoctorPrescriptionController prescriptionController = Get.put(DoctorPrescriptionController());
  final DoctorMainNavigationController navController = Get.find<DoctorMainNavigationController>();

  @override
  void initState() {
    super.initState();
    // Set current index to prescription (index 1)
    navController.setCurrentIndex(1);
  }

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
          'Prescriptions',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Navigation
          tabNavigation(),
          
          // Content
          Expanded(
            child: Obx(() {
              if (prescriptionController.selectedTab.value == 0) {
                return activePrescriptionsList();
              } else {
                return historyPrescriptionsList();
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => DoctorBottomNavigationWidget(
        currentIndex: navController.selectedBottomNavIndex.value,
        onTap: navController.onBottomNavTap,
      )),
    );
  }

  Widget tabNavigation() {
    return Container(
      color: AppColor.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => prescriptionController.switchTab(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: prescriptionController.selectedTab.value == 0 
                      ? AppColor.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Active Prescriptions',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumText.copyWith(
                    color: prescriptionController.selectedTab.value == 0 
                        ? AppColor.primaryColor
                        : AppColor.greyColor,
                    fontSize: 16,
                    fontWeight: prescriptionController.selectedTab.value == 0 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                  ),
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => prescriptionController.switchTab(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: prescriptionController.selectedTab.value == 1 
                      ? AppColor.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'History',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumText.copyWith(
                    color: prescriptionController.selectedTab.value == 1 
                        ? AppColor.primaryColor
                        : AppColor.greyColor,
                    fontSize: 16,
                    fontWeight: prescriptionController.selectedTab.value == 1 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget activePrescriptionsList() {
    return Obx(() => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      itemCount: prescriptionController.activePrescriptionsList.length,
      itemBuilder: (context, index) {
        final prescription = prescriptionController.activePrescriptionsList[index];
        return prescriptionCard(prescription, isActive: true);
      },
    ));
  }

  Widget historyPrescriptionsList() {
    return Obx(() => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      itemCount: prescriptionController.historyPrescriptionsList.length,
      itemBuilder: (context, index) {
        final prescription = prescriptionController.historyPrescriptionsList[index];
        return prescriptionCard(prescription, isActive: false);
      },
    ));
  }

  Widget prescriptionCard(MedicineModel prescription, {required bool isActive}) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Name and Date
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prescription.doctorName ?? "Dr. Smith",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  prescription.prescriptionDate ?? "Today",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          
          // Prescription Card
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? AppColor.primaryColor : Colors.grey.withOpacity(0.3),
                width: isActive ? 2 : 1,
              ),
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
                // Medicine Name
                Text(
                  prescription.medicineName ?? "Medicine Name",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 1.h),
                
                // Dosage and Duration
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Dosage: ${prescription.dosage ?? '500mg'}",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "Duration: ${prescription.duration ?? '7 days'}",
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                
                // Instructions
                if (prescription.instructions != null && prescription.instructions!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Instructions: ${prescription.instructions}",
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                SizedBox(height: 2.h),
                
                // Tags Row
                Row(
                  children: [
                    // Frequency Tag
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        prescription.frequency ?? "2x daily",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    
                    // Timing Tag
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        prescription.timing ?? "After meals",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Spacer(),
                    
                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isActive ? "Active" : "Completed",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
