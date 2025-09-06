import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:metro_project/constants.dart';
import 'package:metro_project/screens/home_screen.dart';
import 'package:metro_project/translations/app_translations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/settings_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //*initalize notification
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // app icon

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //initialize settings
  final settingsController = Get.put(SettingsController());
  await settingsController.loadSettings();

  //initialize supabase
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(MisrMetro());
}

class MisrMetro extends StatelessWidget {
  const MisrMetro({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // Theme settings
        theme: ThemeData.light().copyWith(cardColor: Colors.grey[200]),
        darkTheme: ThemeData.dark().copyWith(cardColor: Colors.white10),
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
