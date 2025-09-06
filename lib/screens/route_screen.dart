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
  RouteScreen({
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
  // kept for compatibility with code that referenced it elsewhere,
  // but we no longer mutate it during build.
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

    if (transferStations.isNotEmpty) {
      final stationToBlock = transferStations.first;
      alternativeGraph[stationToBlock] = alternativeGraph[stationToBlock]!
          .where((neighbor) => neighbor.line == stationToBlock.line)
          .toList();
    }

    final newRoute = bfsRoute(
      widget.fromStation,
      widget.toStation,
      alternativeGraph,
    );

    if (newRoute.isNotEmpty &&
        !_areRoutesSame(widget.originalRoute, newRoute)) {
      setState(() {
        _currentRoute = newRoute;
        _showingAlternative = true;
      });
    } else {
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

      setState(() {
        _showingAlternative = false;
        _changingCount = 0;
      });
      Get.snackbar(
        "No Alternative Found".tr,
        "Cannot find a different route with current constraints".tr,
      );
    }
  }

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

  int _getStationsNumber() {
    int dupCount = 0;
    for (int i = 1; i < _currentRoute.length; i++) {
      if (_currentRoute[i].name == _currentRoute[i - 1].name) dupCount++;
    }
    return _currentRoute.length - dupCount;
  }

  @override
  Widget build(BuildContext context) {
    final int n = _currentRoute.length;
    final List<int> displayIndices = List.filled(n, 0);
    int dupAccum = 0;
    for (int i = 0; i < n; i++) {
      if (i > 0 && _currentRoute[i].name == _currentRoute[i - 1].name) {
        dupAccum++;
      }
      displayIndices[i] = (i + 1) - dupAccum;
    }

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
        padding: EdgeInsets.all(8),
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

                  final displayIndex = displayIndices[index];

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
                        trailing: Icon(Icons.directions, color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
            final currentIndex = _currentRoute.indexOf(_currentStation);

            if (currentIndex == -1) {
              Get.snackbar("Info".tr, "Current station not in route".tr);
              return;
            }

            Get.snackbar(
              "Remaining Time".tr,
              "${"Remaining Time".tr}: ${((_currentRoute.sublist(currentIndex).length - dupAccum) * 2.5).toInt()}",
            );
          },
          tooltip: "Show Remaining Time".tr,
          child: const Icon(Icons.watch_later_outlined, size: 40),
        ),
      ),
    );
  }

  Future<void> _trackLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location Error".tr,
          "Location permissions are denied. Please enable the location permissions in your device\'s settings."
              .tr,
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

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
      if (_currentRoute.length >= 2 &&
          currentStation.name == _currentRoute[_currentRoute.length - 2].name) {
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
