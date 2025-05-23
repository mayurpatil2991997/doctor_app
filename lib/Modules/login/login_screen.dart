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
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppAssets.doctor,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 3.h),
                      CustomTextField(
                        hintText: 'Email or Username',
                        controller: loginController.emailController,
                        keyboardType: null,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Email or Username";
                          }
                          final isEmail = RegExp(r"...").hasMatch(value); // use your regex
                          final isUsername = value.length >= 1;
                          if (!isEmail && !isUsername) {
                            return "Enter a valid Email or Username";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 1.5.h),
                      Obx(() => CustomTextField(
                        hintText: 'Password',
                        controller: loginController.passwordController,
                        keyboardType: null,
                        focusNode: passwordFocusNode,
                        obscureText: !loginController.isPasswordVisible.value,
                        suFixIcon: InkWell(
                          onTap: () {
                            loginController.togglePasswordVisibility();
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          child: Icon(
                            loginController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.blackColor.withOpacity(0.5),
                            size: 26,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else {
                            return FormValidate.validatePassword(
                                value, "Password should be 8 characters");
                          }
                        },
                      )),
                      SizedBox(height: 1.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            // Forgot password navigation
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Text(
                              "Forgot Password?",
                              style: AppTextStyle.mediumText.copyWith(
                                fontSize: 14,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Center(
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
                      ),
                      SizedBox(height: 2.h),

                      Center(
                        child: InkWell(
                          onTap: () {},
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
                      SizedBox(height: 2.h),
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

