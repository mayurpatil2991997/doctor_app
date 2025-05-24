import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final phoneFocusNode = FocusNode();
  final otpFocusNode = FocusNode();
  RxBool showOtp = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      if (phoneController.text.length == 10) {
        showOtp.value = true;
      } else {
        showOtp.value = false;
      }
    });

    otpController.addListener(() {
      showOtp.refresh();
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  void checkPhoneAndShowOtp() {
    final phone = phoneController.text;
    if (phone.length == 10 && RegExp(r'^\d{10}$').hasMatch(phone)) {
      showOtp.value = true;
      phoneFocusNode.unfocus();
      Future.delayed(Duration(milliseconds: 300), () {
        FocusScope.of(Get.context!).requestFocus(otpFocusNode);
      });
    } else {
      showOtp.value = false;
      otpFocusNode.unfocus();
    }
  }

  void sendOtp() {
    Get.snackbar("OTP", "OTP sent to ${phoneController.text}");
  }

}
