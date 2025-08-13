import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhereToGoTextField extends StatelessWidget {
  const WhereToGoTextField({
    super.key,
    required this.locationController,
    required this.onPressed,
    this.onSubmitted,
    this.focusNode,
    required this.suffix,
  });

  final TextEditingController locationController;
  final VoidCallback onPressed;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: locationController,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: "where_to_go".tr,
        prefixIcon: Icon(Icons.location_on_rounded),
        suffixIcon: suffix,
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    );
  }
}
