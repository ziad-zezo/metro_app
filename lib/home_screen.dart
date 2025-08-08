import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:metro_project/route_screen.dart';
import 'package:metro_project/station.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Station> line1Stations = [
    Station(
      'Line1',
      name: 'New El Marg',
      address: Address(latitude: '30.2180', longitude: '31.3405'),
    ),
    Station(
      'Line1',
      name: 'El Marg',
      address: Address(latitude: '30.2205', longitude: '31.3336'),
    ),
    Station(
      'Line1',
      name: 'Ezbet El Nakhl',
      address: Address(latitude: '30.2065', longitude: '31.3364'),
    ),
    Station(
      'Line1',
      name: 'Ain Shams',
      address: Address(latitude: '30.131030', longitude: '31.319092'),
    ),
    Station(
      'Line1',
      name: 'El Matarya',
      address: Address(latitude: '30.1815', longitude: '31.3252'),
    ),
    Station(
      'Line1',
      name: 'Helmeyet El Zaitoun',
      address: Address(latitude: '30.1712', longitude: '31.3205'),
    ),
    Station(
      'Line1',
      name: 'Hadayeq El Zaitoun',
      address: Address(latitude: '30.1615', longitude: '31.3143'),
    ),
    Station(
      'Line1',
      name: 'Saray El Qobba',
      address: Address(latitude: '30.1540', longitude: '31.3092'),
    ),
    Station(
      'Line1',
      name: 'Hammamat El Qobba',
      address: Address(latitude: '30.1449', longitude: '31.3044'),
    ),
    Station(
      'Line1',
      name: 'Kobri El Qobba',
      address: Address(latitude: '30.1376', longitude: '31.2991'),
    ),
    Station(
      'Line1',
      name: 'Manshiet El Sadr',
      address: Address(latitude: '30.1305', longitude: '31.2943'),
    ),
    Station(
      'Line1',
      name: 'El Demerdash',
      address: Address(latitude: '30.1224', longitude: '31.2897'),
    ),
    Station(
      'Line1',
      name: 'Ghamra',
      address: Address(latitude: '30.1165', longitude: '31.2841'),
    ),
    Station(
      'Line1',
      name: 'El Shohadaa',
      address: Address(latitude: '30.061362', longitude: '31.246164'),
    ),
    Station(
      'Line1',
      name: 'Orabi',
      address: Address(latitude: '30.1045', longitude: '31.2415'),
    ),
    Station(
      'Line1',
      name: 'Nasser',
      address: Address(latitude: '30.1012', longitude: '31.2353'),
    ),
    Station(
      'Line1',
      name: 'Sadat',
      address: Address(latitude: '30.0455', longitude: '31.2336'),
    ),
    Station(
      'Line1',
      name: 'Saad Zaghloul',
      address: Address(latitude: '30.0342', longitude: '31.2410'),
    ),
    Station(
      'Line1',
      name: 'Sayeda Zeinab',
      address: Address(latitude: '30.0267', longitude: '31.2436'),
    ),
    Station(
      'Line1',
      name: 'El Malek El Saleh',
      address: Address(latitude: '30.0167', longitude: '31.2457'),
    ),
    Station(
      'Line1',
      name: 'Mar Girgis',
      address: Address(latitude: '30.0089', longitude: '31.2463'),
    ),
    Station(
      'Line1',
      name: 'El Zahraa',
      address: Address(latitude: '29.9988', longitude: '31.2497'),
    ),
    Station(
      'Line1',
      name: 'Dar El Salam',
      address: Address(latitude: '29.9865', longitude: '31.2554'),
    ),
    Station(
      'Line1',
      name: 'Hadayek El Maadi',
      address: Address(latitude: '29.9748', longitude: '31.2588'),
    ),
    Station(
      'Line1',
      name: 'Maadi',
      address: Address(latitude: '29.9628', longitude: '31.2595'),
    ),
    Station(
      'Line1',
      name: 'Sakanat El Maadi',
      address: Address(latitude: '29.9525', longitude: '31.2604'),
    ),
    Station(
      'Line1',
      name: 'Tora El Balad',
      address: Address(latitude: '29.9426', longitude: '31.2622'),
    ),
    Station(
      'Line1',
      name: 'Kozzika',
      address: Address(latitude: '29.9319', longitude: '31.2646'),
    ),
    Station(
      'Line1',
      name: 'Tora El Asmant',
      address: Address(latitude: '29.9215', longitude: '31.2662'),
    ),
    Station(
      'Line1',
      name: 'El Maasara',
      address: Address(latitude: '29.9108', longitude: '31.2685'),
    ),
    Station(
      'Line1',
      name: 'Hadayek Helwan',
      address: Address(latitude: '29.9001', longitude: '31.2698'),
    ),
    Station(
      'Line1',
      name: 'Wadi Hof',
      address: Address(latitude: '29.8900', longitude: '31.2720'),
    ),
    Station(
      'Line1',
      name: 'Helwan University',
      address: Address(latitude: '29.8804', longitude: '31.2743'),
    ),
    Station(
      'Line1',
      name: 'Ain Helwan',
      address: Address(latitude: '29.8711', longitude: '31.2765'),
    ),
    Station(
      'Line1',
      name: 'Helwan',
      address: Address(latitude: '29.8620', longitude: '31.2789'),
    ),
  ];
  final List<Station> line2Stations = [
    Station(
      'Line2',
      name: 'Shubra El Kheima',
      address: Address(latitude: '30.124148', longitude: '31.243305'),
    ),
    Station(
      'Line2',
      name: 'Kolyat El Zeraa',
      address: Address(latitude: '30.113689', longitude: '31.248673'),
    ),
    Station(
      'Line2',
      name: 'Mezallat',
      address: Address(latitude: '30.104177', longitude: '31.245645'),
    ),
    Station(
      'Line2',
      name: 'Khalafawy',
      address: Address(latitude: '30.097235', longitude: '31.245497'),
    ),
    Station(
      'Line2',
      name: 'St. Teresa',
      address: Address(latitude: '30.087959', longitude: '31.245497'),
    ),
    Station(
      'Line2',
      name: 'Rod El Farag',
      address: Address(latitude: '30.101906', longitude: '31.184425'),
    ),
    Station(
      'Line2',
      name: 'Masarra',
      address: Address(latitude: '30.070899', longitude: '31.245105'),
    ),
    Station(
      'Line2',
      name: 'El Shohadaa',
      address: Address(latitude: '30.061366', longitude: '31.246164'),
    ), // shared with Line 1
    Station(
      'Line2',
      name: 'Attaba',
      address: Address(latitude: '30.052349', longitude: '31.246798'),
    ),
    Station(
      'Line2',
      name: 'Naguib',
      address: Address(latitude: '30.045323', longitude: '31.244163'),
    ),
    Station(
      'Line2',
      name: 'Sadat',
      address: Address(latitude: '30.044146', longitude: '31.234434'),
    ), // shared with Line 1
    Station(
      'Line2',
      name: 'Opera',
      address: Address(latitude: '30.041951', longitude: '31.224981'),
    ),
    Station(
      'Line2',
      name: 'Dokki',
      address: Address(latitude: '30.038439', longitude: '31.212231'),
    ),
    Station(
      'Line2',
      name: 'Bohooth',
      address: Address(latitude: '30.035599', longitude: '31.200139'),
    ),
    Station(
      'Line2',
      name: 'Cairo University',
      address: Address(latitude: '30.025341', longitude: '31.201789'),
    ),
    Station(
      'Line2',
      name: 'Faisal',
      address: Address(latitude: '30.017054', longitude: '31.203978'),
    ),
    Station(
      'Line2',
      name: 'Giza',
      address: Address(latitude: '30.011233', longitude: '31.206567'),
    ),
    Station(
      'Line2',
      name: 'Omm El Misryeen',
      address: Address(latitude: '30.005657', longitude: '31.208125'),
    ),
    Station(
      'Line2',
      name: 'Sakiat Mekki',
      address: Address(latitude: '29.995491', longitude: '31.208656'),
    ),
    Station(
      'Line2',
      name: 'El Monib',
      address: Address(latitude: '29.981090', longitude: '31.212322'),
    ),
  ];
  List<Station> line3Stations = [
    Station(
      'Line3',
      name: 'Adly Mansour',
      address: Address(latitude: '30.1470178', longitude: '31.4212334'),
    ),
    Station(
      'Line3',
      name: 'El Nozha',
      address: Address(latitude: '24.7481415', longitude: '46.7123377'),
    ),
    Station(
      'Line3',
      name: 'Hisham Barakat',
      address: Address(latitude: '30.1308273', longitude: '31.3729342'),
    ),
    Station(
      'Line3',
      name: 'Omar Ibn El Khattab',
      address: Address(latitude: '30.1403777', longitude: '31.3943449'),
    ),
    Station(
      'Line3',
      name: 'Qobaa',
      address: Address(latitude: '30.1348259', longitude: '31.3837468'),
    ),
    Station(
      'Line3',
      name: 'Haykestep',
      address: Address(latitude: '31.1438512', longitude: '31.4046952'),
    ),
    Station(
      'Line3',
      name: 'El Shams Club',
      address: Address(latitude: '30.1258187', longitude: '31.3487936'),
    ),
    Station(
      'Line3',
      name: 'Alf Maskan',
      address: Address(latitude: '30.1187129', longitude: '31.3400513'),
    ),
    Station(
      'Line3',
      name: 'Heliopolis Square',
      address: Address(latitude: '30.1084161', longitude: '31.3383119'),
    ),
    Station(
      'Line3',
      name: 'Haroun',
      address: Address(latitude: '30.1013792', longitude: '31.3329857'),
    ),
    Station(
      'Line3',
      name: 'Al Ahram',
      address: Address(latitude: '30.0916945', longitude: '31.3262949'),
    ),
    Station(
      'Line3',
      name: 'Kolleyet El Banat',
      address: Address(latitude: '30.0834405', longitude: '31.3288437'),
    ),
    Station(
      'Line3',
      name: 'Stadium',
      address: Address(latitude: '30.0731738', longitude: '31.3172864'),
    ),
    Station(
      'Line3',
      name: 'Fair Zone',
      address: Address(latitude: '30.0737976', longitude: '31.3015079'),
    ),
    Station(
      'Line3',
      name: 'Abbassia',
      address: Address(latitude: '30.0720747', longitude: '31.2833390'),
    ),
    Station(
      'Line3',
      name: 'Abdou Pasha',
      address: Address(latitude: '30.0649168', longitude: '31.2749135'),
    ),
    Station(
      'Line3',
      name: 'El Geish',
      address: Address(latitude: '30.0617275', longitude: '31.2670282'),
    ),
    Station(
      'Line3',
      name: 'Bab El Shaaria',
      address: Address(latitude: '30.0541670', longitude: '31.2563801'),
    ),
    Station(
      'Line3',
      name: 'Attaba',
      address: Address(latitude: '30.0523497', longitude: '31.2468097'),
    ),
    // shared with Line 2
    Station(
      'Line3',
      name: 'Nasser',
      address: Address(latitude: '30.0534978', longitude: '31.2387352'),
    ),
    // shared with Line 1
    Station(
      'Line3',
      name: 'Maspero',
      address: Address(latitude: '30.0557230', longitude: '31.2321125'),
    ),
    Station(
      'Line3',
      name: 'Zamalek',
      address: Address(latitude: '30.0627367', longitude: '31.2219355'),
    ),
    Station(
      'Line3',
      name: 'Kit Kat',
      address: Address(latitude: '30.0665499', longitude: '31.2130259'),
    ),
  ];
  final isLocationLoading = false.obs;

  final fromFocusNode = FocusNode();

  final toFocusNode = FocusNode();

  Station? fromStation;
  Station? nearestDetectedStation;
  Station? toStation;

  @override
  void initState() {
    super.initState();

    getNearestStation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Metro Guide"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 20,
          children: [
            //*From Station Container
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (!isLocationLoading.value) {
                          fromStation = nearestDetectedStation;
                          Get.snackbar(
                            'From Station',
                            '${fromStation!.name} Station selected',
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        //   width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isLocationLoading.value
                                ? Colors.grey
                                : Colors.green,
                            width: 2,
                          ),
                        ),
                        child: isLocationLoading.value
                            ? CircularProgressIndicator()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 5,
                                children: [
                                  Icon(Icons.my_location, color: Colors.green),
                                  Text(nearestDetectedStation!.name),
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownMenu<Station>(
                    width: double.infinity, // or a fixed width like 300
                    // focusNode: fromFocusNode,
                    label: Text("From"),
                    initialSelection: fromStation,
                    menuHeight: 250,
                    onSelected: (value) {
                      fromStation = value;
                      fromFocusNode.unfocus();
                    },
                    leadingIcon: Icon((Icons.directions_train_rounded)),
                    //     enableSearch: true,
                    //     enableFilter: true,
                    //requestFocusOnTap: true,
                    dropdownMenuEntries: [
                      for (var station in line2Stations)
                        DropdownMenuEntry(value: station, label: station.name),
                      for (var station in line3Stations)
                        DropdownMenuEntry(value: station, label: station.name),
                    ],
                  ),
                ],
              ),
            ),

            //*To Station Container
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Where to go",
                      prefixIcon: Icon(Icons.location_on_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 15),
                  DropdownMenu<Station>(
                    width: double.infinity, // or a fixed width like 300
                    // focusNode: fromFocusNode,
                    label: Text("To"),
                    initialSelection: toStation,
                    menuHeight: 250,
                    onSelected: (value) {
                      toStation = value;
                      fromFocusNode.unfocus();
                    },
                    leadingIcon: Icon(Icons.directions_train_rounded),

                    // enableSearch: true,
                    //   enableFilter: true,
                    //requestFocusOnTap: true,
                    dropdownMenuEntries: [
                      for (var station in line2Stations)
                        DropdownMenuEntry(value: station, label: station.name),
                      for (var station in line3Stations)
                        DropdownMenuEntry(value: station, label: station.name),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: MaterialButton(
                onPressed: () {
                  if (fromStation != null && toStation != null) {
                    Get.to(
                      RouteScreen(
                        fromStation: fromStation!,
                        toStation: toStation!,
                      ),
                    );
                  } else {
                    Get.snackbar("Select Stations", "No Statins Selected!");
                  }
                },
                color: Colors.green,
                minWidth: double.infinity,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Artifika",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //!
  Future<void> getNearestStation() async {
    isLocationLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Error",
        "Location services are disabled. Please enable the location services in your device's settings.",
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location Error",
          "Location permissions are denied. Please enable the location permissions in your device's settings.",
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Location Error",
        "Location permissions are permanently denied. Please enable the location permissions in your device's settings.",
      );
    }
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    Station? nearestStation;
    //check for the nearest station in line 2
    for (var station in line2Stations) {
      double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        double.parse(station.address.latitude),
        double.parse(station.address.longitude),
      );

      //distance < (nearestStation.distance ?? double.infinity)
      if (nearestStation == null || distance < nearestStation.distance!) {
        nearestStation = station;
        nearestStation.distance = distance;
      }
    }
    //check for the nearest station in line 3
    for (var station in line3Stations) {
      double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        double.parse(station.address.latitude),
        double.parse(station.address.longitude),
      );

      //distance < (nearestStation.distance ?? double.infinity)
      if (distance < nearestStation!.distance!) {
        nearestStation = station;
        nearestStation.distance = distance;
      }
    }
    nearestDetectedStation = nearestStation;
    Get.snackbar("Your Location", "Detected Successfully");
    isLocationLoading.value = false;
  }
}
