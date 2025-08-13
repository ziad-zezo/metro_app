import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonAnimationController extends GetxController {
  var isEnabled = false.obs;
  final color = Colors.grey.obs;
  final width = 100.0.obs;

  void toggleButton() {
    color.value = isEnabled.value ? Colors.green : Colors.grey;
    width.value = isEnabled.value ? 250 : 100.0;
  }
}
