// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class UserInfoController extends GetxService {
//   var userId = "".obs;
//   var authToken = "".obs;
//   var email = "".obs;
//   var name = "".obs;
//   var username = "".obs;
//   var slogan = "".obs;
//   var contactNumber = "".obs;
//   var contactNumberCountryCode = "".obs;
//   var city = "".obs;
//   var state = "".obs;
//   var country = "".obs;
//   var pincode = "".obs;
//   var gender = "".obs;
//   var dob = "".obs;
//   var status = "".obs;
//   var kindness = "".obs;
//   var altruism = "".obs;
//   var righteousness = "".obs;
//   var mindfulness = "".obs;
//   var authenticity = "".obs;
//   var registrationPlatform = "".obs;
//   var purposeCode = "".obs;
//   var nationality = "".obs;
//   var ethnicity = "".obs;
//   var qualification = "".obs;
//   var profession = "".obs;
//   var referralCode = "".obs;
//   var referredBy = "".obs;
//   var profileImage = "".obs;
//   var role = "".obs;
//   var lastVisibleQuestionId = 0.obs;
//   var surveyAsCompleted = false.obs;
//   var userDobe = UserModel().obs;
//   var filePath = "".obs;
//   var fileName = "".obs;
//
//   getUserProfile() async {
//     var response = await Repository.instance.getUserProfile();
//     if (response is Success) {
//       var profileData = profileModelFromJson(response.response.toString());
//       if (profileData.id != null) {
//         userId.value = profileData.id.toString();
//         email.value = profileData.email ?? "";
//         name.value = profileData.name ?? "";
//         username.value = profileData.username ?? "";
//         slogan.value = profileData.slogan ?? "";
//         contactNumber.value = profileData.contactNumber.toString();
//         contactNumberCountryCode.value = profileData.contactNumberCountryCode.toString();
//         city.value = profileData.city ?? "";
//         state.value = profileData.state ?? "";
//         country.value = profileData.country ?? "";
//         pincode.value = profileData.pincode.toString();
//         gender.value = profileData.gender ?? "";
//         dob.value = profileData.dob ?? "";
//         status.value = profileData.status ?? "";
//         kindness.value = profileData.kindness ?? "";
//         altruism.value = profileData.altruism ?? "";
//         righteousness.value = profileData.righteousness ?? "";
//         mindfulness.value = profileData.mindfulness ?? "";
//         authenticity.value = profileData.authenticity ?? "";
//         registrationPlatform.value = profileData.registrationPlatform ?? "";
//         purposeCode.value = profileData.purposeCode ?? "";
//         nationality.value = profileData.nationality ?? "";
//         ethnicity.value = profileData.ethnicity ?? "";
//         qualification.value = profileData.qualification ?? "";
//         profession.value = profileData.profession ?? "";
//         referralCode.value = profileData.referralCode ?? "";
//         referredBy.value = profileData.referredBy ?? "";
//         profileImage.value = profileData.profileImage ?? "";
//         role.value = profileData.role ?? "";
//       }
//     } else if (response is Failure) {
//       debugPrint("User Profile : ${response.errorResponse}");
//     }
//     var res = await Repository.instance.getUserProfileDoBe();
//     if (res is Success) {
//       userDobe.value = UserModel.fromJson(res.response?.data);
//       referralCode.value = userDobe.value.data?.user?.referralCode ?? "";
//     }
//   }
//
//   getScale() async {
//     var response = await Repository.instance.getScaleApi();
//     if (response is Success) {
//       var scaleData = scale.scaleModelFromJson(response.response.toString());
//       lastVisibleQuestionId.value = scaleData.currentQuestionId ?? 0;
//       surveyAsCompleted.value = scaleData.completed ?? false;
//     } else if (response is Failure) {
//       lastVisibleQuestionId.value = 0;
//       surveyAsCompleted.value = false;
//       debugPrint("User Profile : ${response.errorResponse}");
//     }
//   }
//
//   selectImage() async {
//     Get.dialog(
//       barrierDismissible: true,
//       Dialog(
//         backgroundColor: ColorConstants.primaryColor2,
//         child: IntrinsicHeight(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () async {
//                     if (Get.isDialogOpen ?? false) {
//                       Get.back();
//                     }
//                     var status = await Permission.camera.status;
//                     if (status.isDenied) {
//                       await Permission.camera.request();
//                     }
//                     if (await Permission.camera.isPermanentlyDenied) {
//                       openAppSettings();
//                     }
//
//                     if (await Permission.camera.isGranted) {
//                       var picket = ImagePicker();
//                       var image = await picket.pickImage(source: ImageSource.camera);
//                       if (image != null) {
//                         filePath.value = image.path ?? "";
//                         await userProfile();
//                       }
//                     }
//
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     width: double.infinity,
//                     child: const Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Gap(20),
//                         Icon(
//                           Icons.camera_alt_outlined,
//                           color: Colors.white,
//                           size: 35,
//                         ),
//                         Gap(10),
//                         TextTitleMedium(
//                           text: "Camera",
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: VerticalDivider(),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () async {
//                     if (Get.isDialogOpen ?? false) {
//                       Get.back();
//                     }
//                     var picket = ImagePicker();
//                     var image = await picket.pickImage(source: ImageSource.gallery);
//                     if (image != null) {
//                       filePath.value = image.path ?? "";
//                       await userProfile();
//                     }
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     width: double.infinity,
//                     child: const Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Icon(
//                           Icons.image,
//                           color: Colors.white,
//                           size: 35,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Gallery",
//                           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   userProfileImageUpload() async {
//     var response = await Repository.instance.profileImageUpload(filePath: filePath.value);
//     if (response is Success) {
//       var result = profileUploadModelFromJson(response.response.toString());
//       var imageData = result.fileName?.path?.replaceAll("src/uploads/", "") ?? "";
//       fileName.value = imageData;
//     } else if (response is Failure) {
//       showSnackBarError(message: response.errorResponse.toString());
//     }
//   }
//
//   userProfile() async {
//     showLoader();
//     var response = await Repository.instance.profileImageUpload(filePath: filePath.value);
//     hideLoader(hideOverlay: false);
//     if (response is Success) {
//       var result = profileUploadModelFromJson(response.response.toString());
//       var imageData = result.fileName?.path?.replaceAll("src/uploads/", "") ?? "";
//       await saveProfile(filepath: imageData);
//       await getUserProfile();
//     } else if (response is Failure) {
//       showSnackBarError(message: response.errorResponse.toString());
//     }
//   }
//
//   saveProfile({required String filepath}) async {
//     showLoader();
//     var profile = ProfileModel();
//     profile.profileImage = filepath;
//     var response = await Repository.instance.setUserProfile(
//       profile,
//     );
//     hideLoader(hideOverlay: false);
//     if (response is Success) {
//       await Get.find<UserInfoController>().getUserProfile();
//       // Get.offAllNamed(RoutesName.result);
//     } else if (response is Failure) {
//       showSnackBarError(message: response.errorResponse.toString());
//     }
//   }
//
//   logout() {
//     userId.value = "";
//     authToken.value = "";
//     email.value = "";
//     name.value = "";
//     contactNumber.value = "";
//     contactNumberCountryCode.value = "";
//     city.value = "";
//     state.value = "";
//     country.value = "";
//     pincode.value = "";
//     gender.value = "";
//     dob.value = "";
//     status.value = "";
//     registrationPlatform.value = "";
//     purposeCode.value = "";
//     nationality.value = "";
//     ethnicity.value = "";
//     qualification.value = "";
//     profession.value = "";
//     referralCode.value = "";
//     referredBy.value = "";
//     profileImage.value = "";
//     role.value = "";
//     lastVisibleQuestionId.value = 0;
//     surveyAsCompleted.value = false;
//     userDobe.value = UserModel();
//   }
// }
