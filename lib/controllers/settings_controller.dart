import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  static const String themeKey = 'isDarkMode';
  static const String langKey = 'languageCode';

  var isDarkMode = true.obs;
  var locale = const Locale('en').obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(themeKey) ?? false;
    String langCode = prefs.getString(langKey) ?? 'en';
    locale.value = Locale(langCode);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    Get.updateLocale(locale.value);
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode.value);
  }

  Future<void> changeLanguage(String langCode) async {
    locale.value = Locale(langCode);
    Get.updateLocale(locale.value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, langCode);
  }
}
