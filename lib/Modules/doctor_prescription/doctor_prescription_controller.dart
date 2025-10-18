import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/medicine_model.dart';

class DoctorPrescriptionController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var selectedTab = 0.obs;
  var activePrescriptionsList = <MedicineModel>[].obs;
  var historyPrescriptionsList = <MedicineModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPrescriptionsData();
  }

  void loadPrescriptionsData() {
    isLoading.value = true;
    hasError.value = false;

    // Mock data for active prescriptions
    activePrescriptionsList.value = [
      MedicineModel(
        prescriptionId: 1,
        doctorName: "Dr. Sarah Johnson",
        prescriptionDate: "2024-01-15",
        medicineName: "Amoxicillin",
        dosage: "500mg",
        duration: "7 days",
        frequency: "3x daily",
        timing: "After meals",
        instructions: "Take with plenty of water. Complete the full course even if you feel better.",
        isActive: true,
        status: "Active",
      ),
      MedicineModel(
        prescriptionId: 2,
        doctorName: "Dr. Michael Chen",
        prescriptionDate: "2024-01-14",
        medicineName: "Ibuprofen",
        dosage: "400mg",
        duration: "5 days",
        frequency: "2x daily",
        timing: "With food",
        instructions: "Take with food to avoid stomach upset. Do not exceed recommended dose.",
        isActive: true,
        status: "Active",
      ),
      MedicineModel(
        prescriptionId: 3,
        doctorName: "Dr. Emily Davis",
        prescriptionDate: "2024-01-13",
        medicineName: "Vitamin D3",
        dosage: "1000 IU",
        duration: "30 days",
        frequency: "1x daily",
        timing: "Morning",
        instructions: "Take in the morning with breakfast for better absorption.",
        isActive: true,
        status: "Active",
      ),
    ];

    // Mock data for history prescriptions
    historyPrescriptionsList.value = [
      MedicineModel(
        prescriptionId: 4,
        doctorName: "Dr. Robert Wilson",
        prescriptionDate: "2024-01-10",
        medicineName: "Paracetamol",
        dosage: "500mg",
        duration: "3 days",
        frequency: "3x daily",
        timing: "As needed",
        instructions: "Take for fever and pain relief. Do not exceed 4 doses per day.",
        isActive: false,
        status: "Completed",
      ),
      MedicineModel(
        prescriptionId: 5,
        doctorName: "Dr. Lisa Anderson",
        prescriptionDate: "2024-01-08",
        medicineName: "Cetirizine",
        dosage: "10mg",
        duration: "10 days",
        frequency: "1x daily",
        timing: "Evening",
        instructions: "Take in the evening to avoid drowsiness during the day.",
        isActive: false,
        status: "Completed",
      ),
    ];

    isLoading.value = false;
  }

  void switchTab(int index) {
    selectedTab.value = index;
  }

  void addNewPrescription() {
    Get.snackbar(
      "Add Prescription",
      "Opening prescription form...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void editPrescription(MedicineModel prescription) {
    Get.snackbar(
      "Edit Prescription",
      "Editing ${prescription.medicineName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void deletePrescription(MedicineModel prescription) {
    Get.snackbar(
      "Delete Prescription",
      "Deleting ${prescription.medicineName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void markAsCompleted(MedicineModel prescription) {
    prescription.isActive = false;
    prescription.status = "Completed";
    
    // Move from active to history
    activePrescriptionsList.remove(prescription);
    historyPrescriptionsList.insert(0, prescription);
    
    Get.snackbar(
      "Prescription Completed",
      "${prescription.medicineName} marked as completed",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
