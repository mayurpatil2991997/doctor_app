import 'package:doctor_app/Modules/intro/intro_screen.dart';
import 'package:get/get.dart';

import '../Modules/intro/intro_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.intro,
      page: () => IntroScreen(),
      binding: IntroBinding(),
    ),
  ];
}
