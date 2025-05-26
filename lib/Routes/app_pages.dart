import 'package:doctor_app/Modules/intro/intro_screen.dart';
import 'package:get/get.dart';

import '../Modules/intro/intro_binding.dart';
import '../Modules/login/login_binding.dart';
import '../Modules/login/login_screen.dart';
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
  ];
}
