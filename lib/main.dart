import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';
import 'Themes/app_colors_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Doctor App',
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColor.whiteColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColor.whiteColor,
              foregroundColor: AppColor.blackColor,
              elevation: 0,
            ),
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.primaryColor,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF121212),
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          themeMode: ThemeMode.system,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          initialRoute: AppRoutes.mainNavigation,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
