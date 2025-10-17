import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/doctor_home_model.dart';

class DoctorHomeController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var doctorData = DoctorHomeModel().obs;
  var featureServices = <FeatureService>[].obs;
  var selectedBottomNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctorData();
    loadFeatureServices();
  }

  void loadDoctorData() {
    isLoading.value = true;
    hasError.value = false;
    
    // Mock data based on the image design
    doctorData.value = DoctorHomeModel(
      doctorName: "Doctor",
      doctorType: "Welcome back,",
      hospitalName: "City General Hospital",
      hospitalAddress: "123 Medical Drive, Anytown",
      patientName: "Dr. Amelia Harper",
      patientSpecialization: "Physiotherapist",
      patientImage: "assets/images/doctor.png",
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
      FeatureService(
        title: "Diet",
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      FeatureService(
        title: "Rehab",
        icon: Icons.healing,
        color: Colors.teal,
      ),
      FeatureService(
        title: "Reports",
        icon: Icons.assessment,
        color: Colors.indigo,
      ),
    ];
  }


  void onViewDetails() {
    // Handle view details action
    Get.snackbar(
      "View Details",
      "Opening doctor details...",
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
    switch (service) {
      case "Exercise":
        Get.toNamed('/exercise');
        break;
      case "Diet":
        Get.toNamed('/diet');
        break;
      case "Rehab":
        Get.toNamed('/rehab');
        break;
      case "Reports":
        Get.toNamed('/reports');
        break;
      default:
        Get.snackbar(
          "Feature Service",
          "Opening $service...",
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }

  void onBottomNavTap(int index) {
    selectedBottomNavIndex.value = index;
    switch (index) {
      case 0:
        // Home - already on home screen
        break;
      case 1:
        // Prescription - navigate to medicines/prescription screen
        Get.toNamed('/medicines');
        break;
      case 2:
        // Connect - navigate to connect screen
        Get.toNamed('/connect');
        break;
    }
  }

}
