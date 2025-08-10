import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_project/screens/home_screen.dart';
import 'package:metro_project/translations/app_translations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = Get.put(SettingsController());
  await settingsController.loadSettings();

  await Supabase.initialize(
    url: 'https://kpughuodxdjsodscurmf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtwdWdodW9keGRqc29kc2N1cm1mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2Njk0ODcsImV4cCI6MjA3MDI0NTQ4N30.v52H1nXyx3-WcJjdYbGRZ5km4kddDQFODUPfoyaNZNY',
  );
  runApp(MetroApp());
}

class MetroApp extends StatelessWidget {
  const MetroApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // Theme settings
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        // Language settings
        translations: AppTranslations(),
        locale: settingsController.locale.value,
        fallbackLocale: const Locale('en', 'US'),
        home: HomeScreen(),
      ),
    );
  }
}
