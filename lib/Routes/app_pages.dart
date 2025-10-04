import 'package:doctor_app/Modules/intro/intro_screen.dart';
import 'package:get/get.dart';

import '../Modules/blogs/blogs_binding.dart';
import '../Modules/blogs/blogs_screen.dart';
import '../Modules/doctor_profile/doctor_profile_binding.dart';
import '../Modules/doctor_profile/doctor_profile_screen.dart';
import '../Modules/doctors/doctors_binding.dart';
import '../Modules/doctors/doctors_controller.dart';
import '../Modules/doctors/doctors_screen.dart';
import '../Modules/medicines/medicines_binding.dart';
import '../Modules/medicines/medicines_screen.dart';
import '../Modules/profile/profile_binding.dart';
import '../Modules/profile/profile_screen.dart';
import '../Modules/personal_details/personal_details_binding.dart';
import '../Modules/personal_details/personal_details_screen.dart';
import '../Modules/themes/themes_binding.dart';
import '../Modules/themes/themes_screen.dart';
import '../Modules/family/family_binding.dart';
import '../Modules/family/family_screen.dart';
import '../Modules/ipd_services/ipd_services_binding.dart';
import '../Modules/ipd_services/ipd_services_screen.dart';
import '../Modules/patient_home/patient_home_binding.dart';
import '../Modules/patient_home/patient_home_screen.dart';
import '../Modules/exercise/exercise_binding.dart';
import '../Modules/exercise/exercise_screen.dart';
import '../Modules/home/home_binding.dart';
import '../Modules/home/home_screen.dart';
import '../Modules/intro/intro_binding.dart';
import '../Modules/login/login_binding.dart';
import '../Modules/login/login_screen.dart';
import '../Modules/main_navigation/main_navigation_binding.dart';
import '../Modules/main_navigation/main_navigation_screen.dart';
import '../Modules/register/register_binding.dart';
import '../Modules/register/register_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.intro,
      page: () => IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () => MainNavigationScreen(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorProfile,
      page: () => DoctorProfileScreen(),
      binding: DoctorProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.doctors,
      page: () => DoctorsScreen(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: AppRoutes.blogs,
      page: () => BlogsScreen(),
      binding: BlogsBinding(),
    ),
    GetPage(
      name: AppRoutes.medicines,
      page: () => MedicinesScreen(),
      binding: MedicinesBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.personalDetails,
      page: () => PersonalDetailsScreen(),
      binding: PersonalDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.themes,
      page: () => ThemesScreen(),
      binding: ThemesBinding(),
    ),
    GetPage(
      name: AppRoutes.family,
      page: () => FamilyScreen(),
      binding: FamilyBinding(),
    ),
    GetPage(
      name: AppRoutes.ipdServices,
      page: () => IpdServicesScreen(),
      binding: IpdServicesBinding(),
    ),
    GetPage(
      name: AppRoutes.patientHome,
      page: () => PatientHomeScreen(),
      binding: PatientHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.exercise,
      page: () => ExerciseScreen(),
      binding: ExerciseBinding(),
    ),
  ];
}
