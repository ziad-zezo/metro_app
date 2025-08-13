import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:metro_project/controllers/settings_controller.dart';

class RouteHeader extends StatelessWidget {
  const RouteHeader({
    super.key,
    required this.fromStationName,
    required this.toStationName,
    required this.stationsNumber,
    required this.price,
    required this.time,
  });

  final String fromStationName;
  final String toStationName;
  final String stationsNumber;
  final int price;
  final int time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fromStationName),
              Icon(
                Get.locale!.languageCode == "ar"
                    ? FontAwesomeIcons.leftLong
                    : FontAwesomeIcons.rightLong,
                color: Colors.grey,
              ),
              Text(
                toStationName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(child: Text("${"stations".tr}: $stationsNumber".tr)),
              VerticalDivider(color: Colors.black),
              SizedBox(child: Text("${"time".tr}: $time ${"min".tr}".tr)),
              VerticalDivider(color: Colors.black),

              SizedBox(child: Text("${"price".tr}: $price\$")),
            ],
          ),
        ),
      ],
    );
  }
}
