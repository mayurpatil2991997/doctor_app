import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/doctor_home_model.dart';

class ConnectController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var selectedTabIndex = 0.obs;
  var patientData = DoctorHomeModel().obs;
  var connectOptions = <ConnectOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPatientData();
    loadConnectOptions();
  }

  void loadPatientData() {
    isLoading.value = true;
    hasError.value = false;
    
    // Mock data for patient
    patientData.value = DoctorHomeModel(
      patientName: "Dr. Amelia Harper",
      patientSpecialization: "Physiotherapist",
      patientImage: "assets/images/doctor.png",
      roomNumber: "302",
      wing: "West Wing",
    );
    
    isLoading.value = false;
  }

  void loadConnectOptions() {
    connectOptions.value = [
      ConnectOption(
        title: "Chat",
        subtitle: "Send messages and share files",
        icon: Icons.chat_bubble_outline,
        color: Colors.blue,
        onTap: () => onChatTap(),
      ),
      ConnectOption(
        title: "Video Call",
        subtitle: "Face-to-face consultation",
        icon: Icons.videocam_outlined,
        color: Colors.green,
        onTap: () => onVideoCallTap(),
      ),
      ConnectOption(
        title: "Voice Call",
        subtitle: "Audio consultation",
        icon: Icons.phone_outlined,
        color: Colors.orange,
        onTap: () => onVoiceCallTap(),
      ),
    ];
  }

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
  }

  void onChatTap() {
    Get.snackbar(
      "Chat",
      "Opening chat with ${patientData.value.patientName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void onVideoCallTap() {
    Get.snackbar(
      "Video Call",
      "Starting video call with ${patientData.value.patientName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void onVoiceCallTap() {
    Get.snackbar(
      "Voice Call",
      "Starting voice call with ${patientData.value.patientName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void onCallPatient() {
    Get.snackbar(
      "Call Patient",
      "Calling ${patientData.value.patientName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void onMessagePatient() {
    Get.snackbar(
      "Message Patient",
      "Opening chat with ${patientData.value.patientName}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void onViewPatientProfile() {
    Get.snackbar(
      "Patient Profile",
      "Opening ${patientData.value.patientName}'s profile...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple,
      colorText: Colors.white,
    );
  }
}

class ConnectOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  ConnectOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
