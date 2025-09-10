import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/family_member_model.dart';
import 'add_family_member_bottom_sheet.dart';

class FamilyController extends GetxController {
  var isLoading = false.obs;
  var familyMembersList = <FamilyMemberModel>[].obs;
  
  // Shared Information Toggle States
  var allergiesEnabled = true.obs;
  var healthRecordsEnabled = true.obs;
  var medicationsEnabled = true.obs;
  var appointmentsEnabled = false.obs;
  var testResultsEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFamilyMembers();
  }

  void loadFamilyMembers() {
    // Mock data - in real app, this would come from API
    familyMembersList.value = [
      // Start with empty list - members will be added via bottom sheet
    ];
  }

  void addFamilyMember() {
    // Show bottom sheet for adding family member
    Get.bottomSheet(
      AddFamilyMemberBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
    );
  }

  void addFamilyMemberToList(FamilyMemberModel member) {
    familyMembersList.add(member);
    Get.back(); // Close bottom sheet
    Get.snackbar(
      "Success",
      "${member.name} has been added to family",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void updateFamilyMember(FamilyMemberModel updatedMember) {
    final index = familyMembersList.indexWhere((member) => member.memberId == updatedMember.memberId);
    if (index != -1) {
      familyMembersList[index] = updatedMember;
      Get.back(); // Close bottom sheet
      Get.snackbar(
        "Success",
        "${updatedMember.name} has been updated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void editFamilyMember(FamilyMemberModel member) {
    // Show bottom sheet for editing family member with pre-filled data
    Get.bottomSheet(
      AddFamilyMemberBottomSheet(memberToEdit: member),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
    );
  }

  void deleteFamilyMember(FamilyMemberModel member) {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Family Member"),
        content: Text("Are you sure you want to delete ${member.name}?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              familyMembersList.remove(member);
              Get.back();
              Get.snackbar(
                "Deleted",
                "${member.name} has been removed from family",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  bool get hasFamilyMembers => familyMembersList.isNotEmpty;
}
