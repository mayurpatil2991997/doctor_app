import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/medicine_model.dart';

class MedicinesController extends GetxController {
  var isLoading = false.obs;
  var activeMedicinesList = <MedicineModel>[].obs;
  var historyMedicinesList = <MedicineModel>[].obs;
  var selectedTab = 0.obs; // 0 for Active, 1 for History

  @override
  void onInit() {
    super.onInit();
    loadMedicinesData();
  }

  void loadMedicinesData() {
    // Mock data matching screenshot
    activeMedicinesList.value = [
      MedicineModel(
        prescriptionId: 1,
        doctorName: "Dr. Chetan Kale",
        prescriptionDate: "02 April, 2025",
        medicineName: "Ibuprofen 200 mg or 400 mg",
        dosage: "200 mg or 400 mg",
        duration: "daily, till 12 Jun",
        frequency: "2 pill once a day",
        timing: "Take one hour before eating",
        instructions: "Take with food to avoid stomach upset",
        isActive: true,
        status: "Active",
      ),
      MedicineModel(
        prescriptionId: 2,
        doctorName: "Dr. Chetan Kale",
        prescriptionDate: "02 April, 2025",
        medicineName: "Ibuprofen 200 mg or 400 mg",
        dosage: "200 mg or 400 mg",
        duration: "daily, till 12 Jun",
        frequency: "2 pill once a day",
        timing: "Take one hour before eating",
        instructions: "Take with food to avoid stomach upset",
        isActive: true,
        status: "Active",
      ),
      MedicineModel(
        prescriptionId: 3,
        doctorName: "Dr. Chetan Kale",
        prescriptionDate: "02 April, 2025",
        medicineName: "Ibuprofen 200 mg or 400 mg",
        dosage: "200 mg or 400 mg",
        duration: "daily, till 12 Jun",
        frequency: "2 pill once a day",
        timing: "Take one hour before eating",
        instructions: "Take with food to avoid stomach upset",
        isActive: true,
        status: "Active",
      ),
    ];

    // Mock history data
    historyMedicinesList.value = [
      MedicineModel(
        prescriptionId: 4,
        doctorName: "Dr. Rajesh Sharma",
        prescriptionDate: "15 March, 2025",
        medicineName: "Paracetamol 500 mg",
        dosage: "500 mg",
        duration: "daily, till 25 Mar",
        frequency: "1 pill twice a day",
        timing: "After meals",
        instructions: "Take with plenty of water",
        isActive: false,
        status: "Completed",
      ),
      MedicineModel(
        prescriptionId: 5,
        doctorName: "Dr. Priya Patel",
        prescriptionDate: "10 March, 2025",
        medicineName: "Amoxicillin 250 mg",
        dosage: "250 mg",
        duration: "daily, till 20 Mar",
        frequency: "1 pill three times a day",
        timing: "Before meals",
        instructions: "Complete the full course",
        isActive: false,
        status: "Completed",
      ),
    ];
  }

  void switchTab(int index) {
    selectedTab.value = index;
  }

  void markAsCompleted(MedicineModel medicine) {
    medicine.isActive = false;
    medicine.status = "Completed";
    activeMedicinesList.refresh();
    historyMedicinesList.refresh();
    
    Get.snackbar(
      "Medicine Completed",
      "${medicine.medicineName} marked as completed",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void refillMedicine(MedicineModel medicine) {
    Get.snackbar(
      "Refill Request",
      "Refill requested for ${medicine.medicineName}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}
