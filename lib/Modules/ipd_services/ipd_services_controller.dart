import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/ipd_services_model.dart';

class IpdServicesController extends GetxController {
  var isLoading = false.obs;
  var ipdData = Rxn<IpdServicesModel>();
  var selectedTab = 0.obs;

  // Tab options
  final List<String> tabs = ['Admission', 'Bed Status', 'Treatment', 'Discharge'];

  @override
  void onInit() {
    super.onInit();
    loadIpdData();
  }

  void loadIpdData() {
    // Mock data matching the screenshot
    ipdData.value = IpdServicesModel(
      patientName: "Rutuja Shelke",
      roomNumber: "Room 302",
      wardType: "Private Ward",
      status: "Active",
      treatmentProgress: 0.75,
      admissionDate: "Oct 15, 2025",
      todaySchedule: [
        ScheduleItem(
          title: "Doctor Visit",
          time: "09:00 AM",
          status: "Completed",
          dotColor: "green",
        ),
        ScheduleItem(
          title: "Medication",
          time: "11:00 AM",
          status: "Upcoming",
          dotColor: "grey",
        ),
        ScheduleItem(
          title: "Physical Therapy",
          time: "02:00 PM",
          status: "Upcoming",
          dotColor: "grey",
        ),
      ],
      vitalSigns: [
        VitalSign(
          name: "Heart Rate",
          value: "72",
          unit: "bpm",
          status: "normal",
          icon: "heart",
        ),
        VitalSign(
          name: "Blood Pressure",
          value: "120/80",
          unit: "",
          status: "normal",
          icon: "blood_drop",
        ),
        VitalSign(
          name: "Temperature",
          value: "98.6",
          unit: "F",
          status: "normal",
          icon: "thermometer",
        ),
        VitalSign(
          name: "Oxygen Saturation",
          value: "98",
          unit: "%",
          status: "normal",
          icon: "oxygen",
        ),
      ],
      recentDocuments: [
        Document(
          title: "Latest Blood Test",
          date: "March 1, 2025",
          type: "blood_test",
        ),
        Document(
          title: "X-Ray Report",
          date: "Feb 12, 2025",
          type: "xray",
        ),
        Document(
          title: "Doctor Notes",
          date: "March 1, 2025",
          type: "notes",
        ),
      ],
      insuranceInfo: InsuranceInfo(
        provider: "HealthCare Plus",
        policyNumber: "#HC123456789",
        claimProgress: 0.75,
        claimStatus: "75% Processed",
      ),
    );
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void callEmergency() {
    Get.snackbar(
      "Emergency",
      "Emergency services have been contacted",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void callNurse() {
    Get.snackbar(
      "Call Nurse",
      "Nurse has been notified and will arrive shortly",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void downloadDocument(Document document) {
    Get.snackbar(
      "Download",
      "Downloading ${document.title}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'upcoming':
        return Colors.grey;
      case 'active':
        return Colors.green;
      case 'normal':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color getDotColor(String color) {
    switch (color.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData getVitalIcon(String icon) {
    switch (icon.toLowerCase()) {
      case 'heart':
        return Icons.favorite;
      case 'blood_drop':
        return Icons.water_drop;
      case 'thermometer':
        return Icons.thermostat;
      case 'oxygen':
        return Icons.air;
      default:
        return Icons.medical_services;
    }
  }
}
