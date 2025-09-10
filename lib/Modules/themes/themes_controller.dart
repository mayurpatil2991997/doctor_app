import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

class ThemesController extends GetxController {
  var selectedTheme = AppThemeMode.light.obs;
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with system theme or default to light
    _initializeTheme();
  }

  void _initializeTheme() {
    // Check system theme preference
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      selectedTheme.value = AppThemeMode.system;
      isDarkMode.value = true;
    } else {
      selectedTheme.value = AppThemeMode.light;
      isDarkMode.value = false;
    }
  }

  void selectTheme(AppThemeMode theme) {
    selectedTheme.value = theme;
    
    switch (theme) {
      case AppThemeMode.light:
        isDarkMode.value = false;
        Get.changeThemeMode(ThemeMode.light);
        break;
      case AppThemeMode.dark:
        isDarkMode.value = true;
        Get.changeThemeMode(ThemeMode.dark);
        break;
      case AppThemeMode.system:
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        isDarkMode.value = brightness == Brightness.dark;
        Get.changeThemeMode(ThemeMode.system);
        break;
    }
    
    // Show confirmation message
    Get.snackbar(
      "Theme Changed",
      "Theme updated to ${_getThemeDisplayName(theme)}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  String _getThemeDisplayName(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return "Light Mode";
      case AppThemeMode.dark:
        return "Dark Mode";
      case AppThemeMode.system:
        return "System Default";
    }
  }

  bool isSelected(AppThemeMode theme) {
    return selectedTheme.value == theme;
  }

  String getSelectedThemeName() {
    return _getThemeDisplayName(selectedTheme.value);
  }
}
