import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //color: Colors.grey[50],
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: child,
    );
  }
}
