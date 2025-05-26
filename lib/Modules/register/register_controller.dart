import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Routes/app_routes.dart';

class RegisterController extends GetxController {

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  var selectedGender = ''.obs;
  var selectedBloodGroup = ''.obs;
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<String> bloodGroupOptions = ['A+', 'A-', 'B+','B-','AB+','AB-','O+','O-'];

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final dobController  = TextEditingController();

  final fNameFocusNode = FocusNode();
  final lNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final pinCodeFocusNode = FocusNode();
  RxBool showOtp = false.obs;

  void pickDate(BuildContext context) async {
    DateTime initial = selectedDate.value ?? DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
