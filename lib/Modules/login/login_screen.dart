import 'package:doctor_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../Utils/app_validator.dart';
import '../../constants/app_const_assets.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../intro/intro_controller.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColor.bgColor,
                child: Image.asset(
                  AppAssets.doctor,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                height: screenHeight,
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Login",
                            style: AppTextStyle.boldText.copyWith(
                              color: AppColor.blackColor,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Your health journey starts here.",
                            style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          CustomTextField(
                            hintText: 'Email Phone Number',
                            controller: loginController.phoneController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            focusNode: loginController.phoneFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                              if (value.length != 10 ||
                                  !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Enter valid 10-digit number';
                              }
                              return null;
                            },
                            onChanged: (_) => loginController.checkPhoneAndShowOtp(),
                          ),
                          SizedBox(height: 2.h),
                          Obx(() => loginController.showOtp.value
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Enter OTP sent to your number"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: "Enter 6-digit OTP",
                                controller: loginController.otpController,
                                keyboardType: TextInputType.number,
                                focusNode: loginController.otpFocusNode,
                                maxLength: 6,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter OTP';
                                  }
                                  if (value.length != 6) {
                                    return 'OTP must be 6 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                              : SizedBox()),
                          SizedBox(height: 2.h),
                          Obx(() {
                            final isOtpEntered = loginController.otpController.text.length == 6;
                            return loginController.showOtp.value && isOtpEntered
                                ? Center(
                              child: ButtonWidget(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    // loginController.signIn();
                                  }
                                },
                                text: "Login",
                                textStyle: AppTextStyle.mediumText.copyWith(
                                  color: AppColor.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            )
                                : SizedBox();
                          }),

                        ],
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.register);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: AppTextStyle.mediumText.copyWith(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: AppTextStyle.mediumText.copyWith(
                                    color: AppColor.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

