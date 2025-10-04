import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'patient_home_model.dart';

class PatientHomeController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var patientData = PatientHomeModel().obs;
  var featureServices = <FeatureService>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPatientData();
    loadFeatureServices();
  }

  void loadPatientData() {
    isLoading.value = true;
    hasError.value = false;
    
    // Mock data based on the image design
    patientData.value = PatientHomeModel(
      patientName: "Patient",
      patientType: "Welcome back,",
      hospitalName: "City General Hospital",
      hospitalAddress: "123 Medical Drive, Anytown",
      doctorName: "Dr. Amelia Harper",
      doctorSpecialization: "Physiotherapist",
      doctorImage: "assets/images/doctor.png",
      roomNumber: "302",
      wing: "West Wing",
      appointmentTitle: "Physiotherapy Session",
      appointmentDate: "July 15, 2024",
      appointmentTime: "2:00 PM",
      exerciseTitle: "Morning Mobility Routine",
      exerciseStartDate: "July 10, 2024",
      bmi: 24.5,
      bmiStatus: "Healthy",
      bloodPressure: "120/80",
      bloodPressureUnit: "mmHg",
    );
    
    isLoading.value = false;
  }

  void loadFeatureServices() {
    featureServices.value = [
      FeatureService(
        title: "Consult",
        icon: Icons.headset_mic,
        color: Colors.green,
      ),
      FeatureService(
        title: "Therapy",
        icon: Icons.arrow_outward,
        color: Colors.blue,
      ),
      FeatureService(
        title: "Exercise",
        icon: Icons.fitness_center,
        color: Colors.purple,
      ),
    ];
  }

  void onCallDoctor() {
    // Handle call doctor action
    Get.snackbar(
      "Call Doctor",
      "Calling ${patientData.value.doctorName}...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onMessageDoctor() {
    // Handle message doctor action
    Get.snackbar(
      "Message Doctor",
      "Opening chat with ${patientData.value.doctorName}...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewDetails() {
    // Handle view details action
    Get.snackbar(
      "View Details",
      "Opening patient details...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewAllAppointments() {
    // Handle view all appointments action
    Get.snackbar(
      "View All Appointments",
      "Opening appointments list...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewAllExercises() {
    // Handle view all exercises action
    Get.snackbar(
      "View All Exercises",
      "Opening exercise plans...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onFeatureServiceTap(String service) {
    // Handle feature service tap
    if (service == "Exercise") {
      Get.toNamed('/exercise');
    } else {
      Get.snackbar(
        "Feature Service",
        "Opening $service...",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
