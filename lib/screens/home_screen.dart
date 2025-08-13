import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:metro_project/helper/internet_checker.dart';
import 'package:metro_project/helper/stations.dart';
import 'package:metro_project/screens/settings_page.dart';
import 'package:metro_project/services/supabase_service.dart';

import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _loadStations();
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [HomePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_isLoading
          ? AppBar(title: Text("Misr Metro".tr), centerTitle: true)
          : null,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? Center(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  SizedBox(
                    height: 170,
                    width: 300,
                    child: Lottie.asset(
                      'assets/animations/train.json',
                      //   width: 80,
                      // height: 80,
                      fit: BoxFit.fill,
                      backgroundLoading: true,
                    ),
                  ),
                  Text(
                    "Loading stations".tr,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      "Misr Metro by Ziad Mohamed",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: IndexedStack(index: _selectedIndex, children: _pages),
            ),
      bottomNavigationBar: !_isLoading
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              enableFeedback: true,
              selectedItemColor: Colors.green,
              type: BottomNavigationBarType.shifting,
              elevation: 1,
              showUnselectedLabels: true,
              showSelectedLabels: false,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house),
                  activeIcon: Icon(FontAwesomeIcons.house),
                  label: "home".tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.gear),
                  label: "settings".tr,
                ),
              ],
            )
          : null,
    );
  }

  Future<void> _loadStations() async {
    _isLoading = true;
    line1Stations = await SupabaseService().getStationsByLine(line: 1);
    line2Stations = await SupabaseService().getStationsByLine(line: 2);
    line3Stations = await SupabaseService().getStationsByLine(line: 3);
    print("the inter");

    bool isConnected = await InternetChecker.isConnectedToInternet();
    if (!isConnected) {
      showDialog(
        context: context,
        barrierDismissible: false, // can't dismiss by tapping outside
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Funny animation
                Card(
                  color: Colors.grey,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Icon(
                      Icons.wifi_off_outlined,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  "No Internet Connection",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Please check your connection and try again.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 15),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _loadStations();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                ),
              ],
            ),
          );
        },
      );
    } else {
      if (line1Stations != null &&
          line2Stations != null &&
          line3Stations != null) {
        _isLoading = false;
        setState(() {});
      }
    }
  }
}
