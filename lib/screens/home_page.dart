import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:metro_project/helper/stations.dart';
import 'package:metro_project/screens/route_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/button_animation_controller.dart';
import '../graph/metro_graph.dart';
import '../helper/internet_checker.dart';
import '../models/station_model.dart';
import '../widgets/custom_container.dart';
import '../widgets/stations_drop_down_menu.dart';
import '../widgets/where_to_go_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final buttonAnimationController = Get.put(ButtonAnimationController());

  final locationController = TextEditingController();
  final locationTextFieldFocusNode = FocusNode();
  final toDropDownFocusNode = FocusNode();
  final fromDropDownFocusNode = FocusNode();
  StationModel? fromStation;
  StationModel? nearestDetectedStation;
  StationModel? toStation;
  final isLocationLoading = false.obs;
  final _isSearching = false.obs;
  bool _isSelectedNearestStation = false;
  bool _isSearchDisabled = false;

  @override
  void initState() {
    super.initState();
    initUserLocation();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 10,
        children: [
          //*From Station Container
          CustomContainer(
            child: Column(
              children: [
                Text("--  ${"from".tr}  --", style: TextStyle(fontSize: 20)),

                SizedBox(height: 5),
                Obx(
                  () => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: !isLocationLoading.value
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        if (_isSelectedNearestStation) {
                          return;
                        }

                        if (!isLocationLoading.value) {
                          setState(() {
                            fromStation = nearestDetectedStation;
                          });
                          Get.snackbar('from_station'.tr, fromStation!.name.tr);
                        }
                        validateStartButton();
                        _isSelectedNearestStation = true;
                        Future.delayed(
                          Duration(seconds: 3),
                          () => _isSelectedNearestStation = false,
                        );
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),

                      title: isLocationLoading.value
                          ? Text("Loading...".tr)
                          : RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(
                                  context,
                                ).style, // Base style
                                children: [
                                  TextSpan(
                                    text: "The closest station to you is".tr,
                                  ),
                                  TextSpan(
                                    text: nearestDetectedStation!.name.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      leading: Icon(Icons.my_location, color: Colors.green),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green.withAlpha(150),
                            ),
                          ),
                          child: isLocationLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : GestureDetector(
                                  onTap: () {
                                    try {
                                      launchUrl(
                                        Uri.parse(
                                          "https://maps.google.com/?ll=${nearestDetectedStation!.address.latitude},${nearestDetectedStation!.address.longitude}",
                                        ),
                                      );
                                    } catch (e) {
                                      Get.snackbar("Error".tr, e.toString());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      "assets/icons/location.gif",
                                      width: 40,
                                      height: 45,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                StationsDropDownMenu(
                  focusNode: fromDropDownFocusNode,
                  label: "from".tr,
                  initialStation: fromStation,
                  onSelected: (value) {
                    fromStation = value;
                    fromDropDownFocusNode.unfocus();
                    validateStartButton();
                  },
                  stations: getAllStations(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(FontAwesomeIcons.arrowDownLong, color: Colors.grey[700]),
              Icon(FontAwesomeIcons.arrowDownLong, color: Colors.grey[700]),
            ],
          ),

          //*To Station Container
          CustomContainer(
            child: Column(
              children: [
                Text("--  ${"to".tr}  --", style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                WhereToGoTextField(
                  locationController: locationController,
                  focusNode: locationTextFieldFocusNode,
                  onPressed: searchLocation,
                  onSubmitted: (value) {
                    searchLocation();
                  },
                  suffix: Obx(
                    () => IconButton(
                      onPressed: searchLocation,
                      icon: Icon(
                        Icons.search,
                        color: _isSearching.value ? Colors.grey : Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(height: 15),
                StationsDropDownMenu(
                  focusNode: toDropDownFocusNode,
                  label: 'to'.tr,
                  initialStation: toStation,
                  onSelected: (value) {
                    toStation = value;
                    toDropDownFocusNode.unfocus();
                    validateStartButton();
                  },
                  stations: getAllStations(),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),
          //*Start Button
          Obx(
            () => InkWell(
              onTap: () async {
                if (fromStation != null && toStation != null) {
                  if (fromStation!.name == toStation!.name) {
                    Get.snackbar(
                      "Error".tr,
                      "Please choose different stations.".tr,
                    );
                    return;
                  }
                  final graph = buildGraph(
                    line1Stations!,
                    line2Stations!,
                    line3Stations!,
                  );
                  final route = bfsRoute(fromStation!, toStation!, graph);

                  if (route.isEmpty) {
                    Get.snackbar(
                      "Route Not Found".tr,
                      "No path found between selected stations".tr,
                    );
                  } else {
                    Get.to(
                      RouteScreen(
                        originalRoute: route,
                        fromStation: fromStation!,
                        toStation: toStation!,
                      ),
                    );
                  }
                } else {
                  Get.snackbar(
                    "Select Stations".tr,
                    "No Stations Selected!".tr,
                  );
                }
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 1100),
                width: buttonAnimationController.width.value,
                height: 55,
                decoration: BoxDecoration(
                  color: buttonAnimationController.color.value,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: buttonAnimationController.isEnabled.value
                        ? Colors.green
                        : Colors.grey,
                  ),
                  gradient: LinearGradient(
                    begin: buttonAnimationController.isEnabled.value
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    end: buttonAnimationController.isEnabled.value
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    colors: buttonAnimationController.isEnabled.value
                        ? [Colors.green, Colors.black]
                        : [Colors.blueGrey, Colors.grey],
                  ),
                ),
                curve: Curves.elasticInOut,
                child: Text(
                  "Start".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Artifika",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initUserLocation() async {
    isLocationLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Error".tr,
        'Location services are disabled. Please enable the location services in your device\'s settings.'
            .tr,
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location Error".tr,
          "Location permissions are denied. Please enable the location permissions in your device\'s settings."
              .tr,
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Location Error".tr,
        "Location permissions are permanently denied. Please enable the location permissions in your device\'s settings."
            .tr,
      );
    }
    Position position = await Geolocator.getCurrentPosition();
    nearestDetectedStation = await getNearestStation(
      position.latitude,
      position.longitude,
      getAllStations(),
    );
    Get.snackbar("Your Location".tr, "Detected Successfully".tr);
    isLocationLoading.value = false;
  }

  void validateStartButton() {
    if (fromStation != null &&
        toStation != null &&
        fromStation!.name != toStation!.name) {
      buttonAnimationController.isEnabled.value = true;
    } else {
      buttonAnimationController.isEnabled.value = false;
    }
    buttonAnimationController.toggleButton();
  }

  Future<void> searchLocation() async {
    if (_isSearchDisabled) {
      return;
    }
    _isSearchDisabled = true;
    if (locationController.text.trim().isEmpty) {
      Get.snackbar("search_error".tr, "please_enter_a_location".tr);
      Future.delayed(Duration(seconds: 2), () => _isSearchDisabled = false);
      return;
    }
    locationTextFieldFocusNode.unfocus();
    _isSearching.value = true;
    try {
      final location = await locationFromAddress(locationController.text);
      toStation = await getNearestStation(
        location.first.latitude,
        location.first.longitude,
        getAllStations(),
      );
      setState(() {});
      Get.snackbar("Success".tr, toStation!.name.tr);
      validateStartButton();
    } catch (e) {
      final isConnected = await InternetChecker.isConnectedToInternet();
      if (!isConnected) {
        Get.snackbar("internet_error".tr, "internet_error_message".tr);
      } else {
        Get.snackbar("search_error".tr, "search_error_message".tr);
      }
    }
    Future.delayed(Duration(seconds: 2), () => _isSearchDisabled = false);
    _isSearching.value = false;
  }
}
