import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    // Mock data matching screenshot
    userProfile.value = ProfileModel(
      name: "Dr.Kiran Doke",
      specialization: "Pediatrician",
      email: "kirandoke@gmail.com",
      profileImage: "assets/images/doctor1.jpg",
      phoneNumber: "+91 9876543210",
      address: "Pune, Maharashtra",
      dateOfBirth: "15 March, 1985",
      gender: "Female",
      bloodGroup: "O+",
      emergencyContact: "+91 9876543211",
    );
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/login');
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
