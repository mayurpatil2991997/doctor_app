import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../APIHelper/api_status.dart';
import '../../APIHelper/repository.dart';
import '../../Routes/app_routes.dart';
import '../../Utils/helper_method.dart';
import '../../model/login_model.dart';
import '../../model/send_otp_model.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final phoneFocusNode = FocusNode();
  final otpFocusNode = FocusNode();

  final showSendOtpButton = false.obs;
  final showOtpField = false.obs;
  final showLoginButton = false.obs;

  void checkPhoneAndShowOtp() {
    final number = phoneController.text;
    showSendOtpButton.value = number.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(number);
  }

  Future<void> sendOtp() async {
    showLoader();

    final response = await Repository.instance.sendOtpApi(
      number: phoneController.text,
    );

    hideLoader(hideOverlay: false);

    if (response is Success) {
      var result = sendOtpModelFromJson(response.response.toString());
      showSnackBarSuccess(message: "${result.message.toString()}  ${result.otp}");
      Get.toNamed(AppRoutes.login);
      showOtpField.value = true;
    } else if (response is Failure) {
      showSnackBarError(message: response.errorResponse.toString());
    }
  }

  Future<void> login() async {
    showLoader();

    final response = await Repository.instance.loginApi(
      number: phoneController.text,
      otp: otpController.text,
    );

    hideLoader(hideOverlay: false);

    if (response is Success) {
      var result = loginModelFromJson(response.response.toString());
      showSnackBarSuccess(message: result.message.toString());
      Get.offAllNamed(AppRoutes.mainNavigation);
    } else if (response is Failure) {
      showSnackBarError(message: response.errorResponse.toString());
    }
  }

  void checkOtpLength(String value) {
    showLoginButton.value = value.length == 6;
  }
}

