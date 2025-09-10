import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/doctor_model.dart';

class DoctorsController extends GetxController {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  
  var isLoading = false.obs;
  var doctorsList = <DoctorModel>[].obs;
  var filteredDoctorsList = <DoctorModel>[].obs;
  var selectedSpecialization = 'General Physician'.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctorsData();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void loadDoctorsData() {
    // Mock data matching your screenshot
    doctorsList.value = [
      DoctorModel(
        doctorId: 1,
        name: "Dr. Kiran Doke",
        specialization: "Pediatrician (5years Exp)",
        experience: "5 years",
        image: "assets/images/doctor1.jpg",
        rating: 4.5,
        consultationFee: 600,
        isAvailable: true,
        availabilityStatus: "Available Now",
        isVideoConsult: true,
      ),
      DoctorModel(
        doctorId: 2,
        name: "Dr. Kiran Doke",
        specialization: "Pediatrician (5years Exp)",
        experience: "5 years",
        image: "assets/images/doctor1.jpg",
        rating: 4.5,
        consultationFee: 600,
        isAvailable: true,
        availabilityStatus: "Available Now",
        isVideoConsult: true,
      ),
      DoctorModel(
        doctorId: 3,
        name: "Dr. Rajesh Sharma",
        specialization: "General Physician (8years Exp)",
        experience: "8 years",
        image: "assets/images/doctor1.jpg",
        rating: 4.7,
        consultationFee: 800,
        isAvailable: false,
        availabilityStatus: "Available in 2 hours",
        isVideoConsult: true,
      ),
      DoctorModel(
        doctorId: 4,
        name: "Dr. Priya Patel",
        specialization: "Dermatologist (6years Exp)",
        experience: "6 years",
        image: "assets/images/doctor1.jpg",
        rating: 4.3,
        consultationFee: 700,
        isAvailable: true,
        availabilityStatus: "Available Now",
        isVideoConsult: false,
      ),
    ];
    
    filteredDoctorsList.value = doctorsList;
  }

  void searchDoctors(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredDoctorsList.value = doctorsList;
    } else {
      filteredDoctorsList.value = doctorsList.where((doctor) {
        return doctor.name!.toLowerCase().contains(query.toLowerCase()) ||
               doctor.specialization!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void bookAppointment(DoctorModel doctor) {
    // Handle appointment booking
    Get.snackbar(
      "Appointment",
      "Booking appointment with ${doctor.name}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
    );
  }

  String getDoctorsFoundText() {
    return "${filteredDoctorsList.length} Doctors found in";
  }
}
