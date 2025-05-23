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


  // @override
  // Widget build(BuildContext context) {
  //   return GetBuilder<LoginController>(
  //     builder:
  //         (controller) => WillPopScope(
  //       onWillPop: () async {
  //         SystemNavigator.pop();
  //         return false;
  //       },
  //       child: Scaffold(
  //         backgroundColor: AppColor.whiteColor,
  //         body: SingleChildScrollView(
  //           child: Form(
  //             key: formKey,
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 4.w),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     height: 10.h,
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       "Sign In",
  //                       style: AppTextStyle.boldText.copyWith(
  //                         fontSize: 26,
  //                         color: AppColor.primaryColor,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 3.h),
  //                   Center(
  //                     child: Text(
  //                       "Your health journey starts here.",
  //                       style: AppTextStyle.mediumText.copyWith(
  //                         fontSize: 16,
  //                         color: AppColor.primaryColor,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 2.h),
  //                   CustomTextField(
  //                       hintText: 'Email or Username',
  //                       controller: loginController.emailController,
  //                       keyboardType: null,
  //                       focusNode: emailFocusNode,
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return "Please enter Email or Username";
  //                         }
  //
  //                         final isEmail = RegExp(r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$").hasMatch(value);
  //                         final isUsername = value.length >= 1; // You can set your own rule
  //
  //                         if (!isEmail && !isUsername) {
  //                           return "Enter a valid Email or Username (min 3 chars)";
  //                         }
  //
  //                         return null;
  //                       }
  //
  //                   ),
  //                   SizedBox(height: 1.5.h),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       Obx(
  //                             () => FocusScope(
  //                           node: FocusScopeNode(),
  //                           child: CustomTextField(
  //                             hintText: 'Password',
  //                             controller: loginController.passwordController,
  //                             keyboardType: null,
  //                             focusNode: passwordFocusNode,
  //                             obscureText:
  //                             !loginController.isPasswordVisible.value,
  //                             suFixIcon: InkWell(
  //                               onTap: () {
  //                                 loginController.togglePasswordVisibility();
  //                                 FocusScope.of(
  //                                   context,
  //                                 ).requestFocus(passwordFocusNode);
  //                               },
  //                               child: Icon(
  //                                 loginController.isPasswordVisible.value
  //                                     ? Icons.visibility
  //                                     : Icons.visibility_off,
  //                                 color: AppColor.blackColor.withOpacity(0.5),
  //                                 size: 26,
  //                               ),
  //                             ),
  //                             validator: (value) {
  //                               if (value!.isEmpty) {
  //                                 return "Please Enter Password";
  //                               } else {
  //                                 return FormValidate.validatePassword(
  //                                   value,
  //                                   "Password should be 8 character",
  //                                 );
  //                               }
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 0.7.h),
  //                       InkWell(
  //                         onTap: () {
  //                           // Get.toNamed(AppRoutes.forgot);
  //                         },
  //                         child: Padding(
  //                           padding: EdgeInsets.only(right: 2.w),
  //                           child: Text(
  //                             "Forgot Password?",
  //                             style: AppTextStyle.mediumText.copyWith(
  //                               fontSize: 14,
  //                               color: AppColor.primaryColor,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 6.h),
  //                   Center(
  //                     child: ButtonWidget(
  //                       onTap: () {
  //                         if (formKey.currentState!.validate()) {
  //                           // loginController.signIn();
  //                         }
  //                       },
  //                       text: "Login",
  //                       textStyle: AppTextStyle.mediumText.copyWith(
  //                         color: AppColor.whiteColor,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 2.h),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          // Top Image
          Stack(
            children: [
              Image.asset(
                AppAssets.doctor,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ],
          ),

          // Form Area
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text("Your health journey starts here."),
                  const SizedBox(height: 24),

                  // Username
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Login Button

                  const Spacer(),

                  // Sign Up
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

