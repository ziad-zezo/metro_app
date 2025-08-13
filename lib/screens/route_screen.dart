import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:metro_project/models/station_model.dart';
import 'package:metro_project/widgets/route_header.dart';
import 'package:url_launcher/url_launcher.dart';

import '../graph/metro_graph.dart';
import '../helper/notifications.dart';
import '../helper/stations.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({
    super.key,
    required this.originalRoute,
    required this.fromStation,
    required this.toStation,
  });

  final List<StationModel> originalRoute;
  final StationModel fromStation;
  final StationModel toStation;

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late List<StationModel> _currentRoute;
  bool _showingAlternative = false;
  int _changingCount = 0;
  late StationModel _currentStation;

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.originalRoute;
    _currentStation = widget.fromStation;
    _trackLocation();
  }

  void _getAlternativeRoute() {
    final graph = buildGraph(line1Stations!, line2Stations!, line3Stations!);

    final alternativeGraph = Map<StationModel, List<StationModel>>.from(graph);

    final transferStations = widget.originalRoute
        .where(
          (station) =>
              graph[station]?.any(
                (neighbor) =>
                    neighbor.name == station.name &&
                    neighbor.line != station.line,
              ) ??
              false,
        )
        .toList();
    // 3. إذا وجدنا محطات نقل، نمنع الاتصال بين بعضها
    if (transferStations.isNotEmpty) {
      final stationToBlock = transferStations.first;
      alternativeGraph[stationToBlock] = alternativeGraph[stationToBlock]!
          .where((neighbor) => neighbor.line == stationToBlock.line)
          .toList();
    }
    // 4. البحث عن مسار جديد
    final newRoute = bfsRoute(
      widget.fromStation,
      widget.toStation,
      alternativeGraph,
    );
    // 5. التحقق من أن المسار مختلف عن الأصلي
    if (newRoute.isNotEmpty &&
        !_areRoutesSame(widget.originalRoute, newRoute)) {
      setState(() {
        _currentRoute = newRoute;
        _showingAlternative = true;
      });
    } else {
      // 6. إذا لم ينجح، نجرب منع محطة نقل أخرى
      if (transferStations.length > 1) {
        final anotherStationToBlock = transferStations[1];
        alternativeGraph[anotherStationToBlock] =
            alternativeGraph[anotherStationToBlock]!
                .where(
                  (neighbor) => neighbor.line == anotherStationToBlock.line,
                )
                .toList();

        final anotherRoute = bfsRoute(
          widget.fromStation,
          widget.toStation,
          alternativeGraph,
        );

        if (anotherRoute.isNotEmpty &&
            !_areRoutesSame(widget.originalRoute, anotherRoute)) {
          setState(() {
            _currentRoute = anotherRoute;
            _showingAlternative = true;
          });
          return;
        }
      }
      _changingCount = 0;
      Get.snackbar(
        "No Alternative Found".tr,
        "Cannot find a different route with current constraints".tr,
      );
    }
  }

  // دالة مساعدة لمقارنة المسارات
  bool _areRoutesSame(List<StationModel> route1, List<StationModel> route2) {
    if (route1.length != route2.length) return false;
    for (int i = 0; i < route1.length; i++) {
      if (route1[i].name != route2[i].name ||
          route1[i].line != route2[i].line) {
        return false;
      }
    }
    return true;
  }

  void _resetToOriginalRoute() {
    _changingCount = 0;
    setState(() {
      _currentRoute = widget.originalRoute;
      _showingAlternative = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("hiii ziad");
    return Scaffold(
      appBar: AppBar(
        title: Text("Route".tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.compare_arrows),
            onPressed: _showingAlternative
                ? _resetToOriginalRoute
                : _getAlternativeRoute,
            tooltip: "Show Alternative Route".tr,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          children: [
            RouteHeader(
              fromStationName: widget.fromStation.name.tr,
              toStationName: widget.toStation.name.tr,
              stationsNumber: _getStationsNumber().toString().tr,
              price: _getPrice(_currentRoute.length),
              time: (_getStationsNumber() * 2.5).toInt(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _currentRoute.length,
                itemBuilder: (context, index) {
                  final station = _currentRoute[index];
                  final nextStation = index < _currentRoute.length - 1
                      ? _currentRoute[index + 1]
                      : null;
                  // حساب الرقم الحقيقي للمحطة مع مراعاة التكرار
                  int displayIndex = index + 1;
                  if (index > 0 &&
                      _currentRoute[index].name ==
                          _currentRoute[index - 1].name) {
                    displayIndex = index; // استخدام نفس الرقم إذا تكررت المحطة
                    _changingCount++;
                  }

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              _currentStation.name == _currentRoute[index].name
                              ? Colors.green.withOpacity(0.15)
                              : Colors.grey.withOpacity(0.15),
                          child:
                              _currentStation.name == _currentRoute[index].name
                              ? Icon(
                                  Icons.my_location,
                                  color: Colors.green,
                                  size: 24,
                                )
                              : Text(
                                  '$displayIndex',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                        title: Text(
                          station.name.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Line ${station.line.numericOnly()}'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Icon(
                          Icons.directions,
                          color: Colors.blueAccent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // tileColor: Colors.white,
                        onTap: () async {
                          final url = Uri.parse(
                            "https://maps.google.com/?ll=${station.address.latitude},${station.address.longitude}",
                          );
                          await launchUrl(url);
                        },
                      ),

                      if (nextStation != null &&
                          nextStation.name == station.name &&
                          nextStation.line != station.line)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Change to Line ${nextStation.line.numericOnly()}"
                                .tr,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_currentRoute.isNotEmpty) {
                            final fromStation = _currentRoute.first;
                            final toStation = _currentRoute.last;
                            final url = Uri.parse(
                              'https://www.google.com/maps/dir/?api=1&origin=${fromStation.address.latitude},${fromStation.address.longitude}&destination=${toStation.address.latitude},${toStation.address.longitude}&travelmode=transit',
                            );
                            await launchUrl(url);
                          }
                        },
                        color: Colors.green,
                        height: 60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Show Route On Map".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Artifika",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            int currentIndex = _currentRoute.indexOf(_currentStation);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${"Remaining Time".tr}: ${(_currentRoute.sublist(currentIndex).length * 2.5).toInt()}",
                ),
              ),
            );
          },
          tooltip: "Show Remaining Time".tr,
          child: const Icon(Icons.watch_later_outlined, size: 40),
        ),
      ),
    );
  }

  int _getStationsNumber() => _currentRoute.length - _changingCount;

  Future<void> _trackLocation() async {
    Get.snackbar("tracking ", "message");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied");
      return;
    }

    // Step 2: Listen to position stream
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high, // High accuracy
        distanceFilter: 100, // Update every 100 meters
      ),
    ).listen((Position position) async {
      final currentStation = await getNearestStation(
        position.latitude,
        position.longitude,
        _currentRoute,
      );
      _currentStation = currentStation;
      setState(() {});
      if (currentStation.name == _currentRoute[_currentRoute.length - 2].name) {
        await showNotification(
          "almost_there_title".tr,
          "almost_there_message".trParams({"station": currentStation.name}),
        );
      } else if (currentStation.name == _currentRoute.last.name) {
        await showNotification(
          "arrived_title".tr,
          "arrived_message".trParams({"station": currentStation.name}),
        );
      }
    });
  }

  int _getPrice(final int numberOfStations) {
    if (_getStationsNumber() <= 9) {
      return 8;
    } else if (_getStationsNumber() <= 16) {
      return 10;
    } else if (_getStationsNumber() <= 23) {
      return 15;
    } else {
      return 20;
    }
  }
}
