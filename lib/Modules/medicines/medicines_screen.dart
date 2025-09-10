import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/medicine_model.dart';
import 'medicines_controller.dart';

class MedicinesScreen extends StatefulWidget {
  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final MedicinesController medicinesController = Get.put(MedicinesController());

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
          'Medicines',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColor.blackColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          tabNavigation(),
          
          // Content
          Expanded(
            child: Obx(() {
              if (medicinesController.selectedTab.value == 0) {
                return activeMedicinesList();
              } else {
                return historyMedicinesList();
              }
            }),
          ),
        ],
      ),
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
              onTap: () => medicinesController.switchTab(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: medicinesController.selectedTab.value == 0 
                      ? AppColor.greyColor.withOpacity(0.5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Active Medicines',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumText.copyWith(
                    color: medicinesController.selectedTab.value == 0 
                        ? AppColor.blackColor
                        : AppColor.greyColor,
                    fontSize: 16,
                  ),
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => medicinesController.switchTab(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: medicinesController.selectedTab.value == 1 
                      ? AppColor.greyColor.withOpacity(0.5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'History',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumText.copyWith(
                    color: medicinesController.selectedTab.value == 1 
                        ? AppColor.blackColor
                        : AppColor.greyColor,
                    fontSize: 16,
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget activeMedicinesList() {
    return Obx(() => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      itemCount: medicinesController.activeMedicinesList.length,
      itemBuilder: (context, index) {
        final medicine = medicinesController.activeMedicinesList[index];
        return medicineCard(medicine, isActive: true);
      },
    ));
  }

  Widget historyMedicinesList() {
    return Obx(() => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      itemCount: medicinesController.historyMedicinesList.length,
      itemBuilder: (context, index) {
        final medicine = medicinesController.historyMedicinesList[index];
        return medicineCard(medicine, isActive: false);
      },
    ));
  }

  Widget medicineCard(MedicineModel medicine, {required bool isActive}) {
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
                  medicine.doctorName ?? "",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  medicine.prescriptionDate ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          
          // Medicine Card
          Container(
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
                // Medicine Name
                Text(
                  medicine.medicineName ?? "",
                  style: AppTextStyle.boldText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 1.h),
                
                // Duration
                Text(
                  medicine.duration ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.blackColor,
                    fontSize: 14,
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
                        medicine.frequency ?? "",
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
                        medicine.timing ?? "",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor,
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
