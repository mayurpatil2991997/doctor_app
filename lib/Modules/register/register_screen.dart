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
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());
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
      backgroundColor: AppColor.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColor.primaryColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Center(
                      child: Text(
                        "Create an Account",
                        style: AppTextStyle.boldText.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 18
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight,
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: AppTextStyle.boldText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          hintText: 'Email First Name',
                          controller: registerController.fNameController,
                          keyboardType: null,
                          focusNode: registerController.fNameFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            if (value.length < 2) {
                              return 'First name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          hintText: 'Enter Last Name',
                          controller: registerController.lNameController,
                          keyboardType: null,
                          focusNode: registerController.lNameFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            if (value.length < 2) {
                              return 'Last name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          hintText: 'Enter Email',
                          controller: registerController.emailController,
                          keyboardType: null,
                          focusNode: registerController.emailFocusNode,
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter Email or Username";
                              }
                  
                              final isEmail = RegExp(r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$").hasMatch(value);
                  
                              if (!isEmail) {
                                return "Enter a valid Email or Username (min 3 chars)";
                              }
                  
                              return null;
                            }
                        ),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: () => registerController.pickDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hintText: 'Date of Birth',
                              controller: registerController.dobController,
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your date of birth';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.greyColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.greyColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.redColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          value: registerController.selectedGender.value.isNotEmpty
                              ? registerController.selectedGender.value
                              : null,
                          items: registerController.genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            registerController.selectedGender.value = newValue ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select gender';
                            }
                            return null;
                          },
                        )),
                        SizedBox(height: 2.h),
                        CustomTextField(
                            hintText: 'Enter Phone',
                            controller: registerController.contactController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            focusNode: registerController.phoneFocusNode,
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
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          hintText: 'Enter Address',
                          controller: registerController.addressController,
                          keyboardType: null,
                          focusNode: registerController.addressFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          hintText: 'Enter PinCode',
                          controller: registerController.pinCodeController,
                          keyboardType: TextInputType.number,
                          focusNode: registerController.pinCodeFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter pinCode';
                            }
                            if (value.length < 6) {
                              return 'Pin code must be at least 6 digit';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Blood Group',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.greyColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.greyColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.redColor,
                                  strokeAlign: 1
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          value: registerController.selectedBloodGroup.value.isNotEmpty
                              ? registerController.selectedBloodGroup.value
                              : null,
                          items: registerController.bloodGroupOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            registerController.selectedBloodGroup.value = newValue ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select blood Group';
                            }
                            return null;
                          },
                        )),
                        SizedBox(height: 2.h),
                        Center(
                          child: ButtonWidget(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                registerController.register();
                              }
                            },
                            text: "Register",
                            textStyle: AppTextStyle.mediumText.copyWith(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.login);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                style: AppTextStyle.mediumText.copyWith(
                                  color: AppColor.blackColor,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign In",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

