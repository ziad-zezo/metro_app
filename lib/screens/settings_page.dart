import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text('dark_mode'.tr),
            trailing: Obx(
              () => Switch(
                value: settingsController.isDarkMode.value,
                onChanged: (value) => settingsController.toggleTheme(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('change_lang'.tr),
            trailing: DropdownButton<String>(
              value: settingsController.locale.value.languageCode,
              items: [
                DropdownMenuItem(value: 'en', child: Text("English")),
                DropdownMenuItem(value: 'ar', child: Text("العربية")),
              ],
              onChanged: (value) {
                if (value != null) {
                  settingsController.changeLanguage(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
