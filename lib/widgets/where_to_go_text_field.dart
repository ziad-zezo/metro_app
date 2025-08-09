import 'package:flutter/material.dart';

class WhereToGoTextField extends StatelessWidget {
  const WhereToGoTextField({
    super.key,
    required this.locationController,
    required this.onPressed,
    this.onSubmitted,
  });
  final TextEditingController locationController;
  final VoidCallback onPressed;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: locationController,
      decoration: InputDecoration(
        hintText: "Where to go",
        prefixIcon: Icon(Icons.location_on_rounded),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.search, color: Colors.green),
        ),
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    );
  }
}
