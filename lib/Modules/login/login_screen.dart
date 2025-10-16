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
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // Header Section with Gradient
                Container(
                  height: 35.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.primaryColor,
                        AppColor.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background Pattern
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -30,
                        left: -30,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.h),
                            // App Logo
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  AppAssets.doctor,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.medical_services,
                                      size: 50,
                                      color: AppColor.primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              "Welcome Back!",
                              style: AppTextStyle.boldText.copyWith(
                                color: AppColor.whiteColor,
                                fontSize: 28,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Sign in to continue your health journey",
                              style: AppTextStyle.mediumText.copyWith(
                                color: AppColor.whiteColor.withOpacity(0.9),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Form Section
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          
                          // Phone Number Field
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CustomTextField(
                              hintText: 'Enter Mobile Number',
                              controller: loginController.phoneController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              focusNode: loginController.phoneFocusNode,
                              preFix: Container(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.phone_android,
                                  color: AppColor.primaryColor,
                                  size: 20,
                                ),
                              ),
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
                          ),
                          
                          SizedBox(height: 3.h),
                          
                          // Send OTP Button
                          Obx(() => loginController.showSendOtpButton.value
                              ? Container(
                                  width: double.infinity,
                                  child: ButtonWidget(
                                    onTap: () {
                                      loginController.sendOtp();
                                    },
                                    height: 7.h,
                                    borderRadius: 15,
                                    text: "Send OTP",
                                    textStyle: AppTextStyle.boldText.copyWith(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : SizedBox()),
                          
                          SizedBox(height: 2.h),
                          
                          // OTP Field
                          Obx(() => loginController.showOtpField.value
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Text(
                                        "Enter OTP sent to your number",
                                        style: AppTextStyle.mediumText.copyWith(
                                          color: AppColor.blackColor.withOpacity(0.7),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: CustomTextField(
                                        hintText: "Enter 6-digit OTP",
                                        controller: loginController.otpController,
                                        keyboardType: TextInputType.number,
                                        focusNode: loginController.otpFocusNode,
                                        maxLength: 6,
                                        preFix: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Icon(
                                            Icons.security,
                                            color: AppColor.primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                        onChanged: loginController.checkOtpLength,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) return 'Please enter OTP';
                                          if (value.length != 6) return 'OTP must be 6 digits';
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox()),
                          
                          SizedBox(height: 3.h),
                          
                          // Login Button
                          Obx(() => loginController.showLoginButton.value
                              ? Container(
                                  width: double.infinity,
                                  child: ButtonWidget(
                                    onTap: () {
                                      loginController.login();
                                    },
                                    height: 7.h,
                                    borderRadius: 15,
                                    text: "Login",
                                    textStyle: AppTextStyle.boldText.copyWith(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : SizedBox()),
                          
                          Spacer(),
                          
                          // Sign Up Link
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.register);
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: "Don't have an account? ",
                                    style: AppTextStyle.mediumText.copyWith(
                                      color: AppColor.blackColor.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Sign Up",
                                        style: AppTextStyle.boldText.copyWith(
                                          color: AppColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}

