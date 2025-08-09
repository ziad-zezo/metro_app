import 'package:flutter/material.dart';
import 'package:metro_project/station.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({
    super.key,
    required this.fromStation,
    required this.toStation,
  });
  final Station fromStation;
  final Station toStation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Route"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaterialButton(
              onPressed: () async {
                final url = Uri.parse(
                  'https://www.google.com/maps/dir/?api=1&origin=${fromStation.address.latitude},${fromStation.address.longitude}&destination=${toStation.address.latitude},${toStation.address.longitude}&travelmode=transit',
                );
                await launchUrl(url);
              },
              color: Colors.green,
              minWidth: double.infinity,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Show On Map",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Artifika",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
