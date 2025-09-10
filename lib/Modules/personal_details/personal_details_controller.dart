import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/personal_details_model.dart';

class PersonalDetailsController extends GetxController {
  var isLoading = false.obs;
  var personalDetails = Rxn<PersonalDetailsModel>();

  @override
  void onInit() {
    super.onInit();
    loadPersonalDetails();
  }

  void loadPersonalDetails() {
    // Mock data matching screenshot
    personalDetails.value = PersonalDetailsModel(
      name: "Kiran Sandeep Doke",
      dateOfBirth: "15-06-1995",
      email: "kirandoke@gmail.com",
      phoneNumber: "1234567890",
      address: "Pune",
      medicalLicenseNumber: "1234",
      specialization: "Pediatrician",
      yearsOfExperience: "10",
    );
  }
}
