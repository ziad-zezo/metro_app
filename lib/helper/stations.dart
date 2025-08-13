import 'package:geolocator/geolocator.dart';
import 'package:metro_project/models/station_model.dart';

List<StationModel>? line1Stations;
List<StationModel>? line2Stations;
List<StationModel>? line3Stations;

List<StationModel> getAllStations() {
  return [...line1Stations!, ...line2Stations!, ...line3Stations!];
}

Future<StationModel> getNearestStation(
  final double latitude,
  final double longitude,
  final List<StationModel> stations,
) async {
  StationModel? nearestStation;
  for (var station in stations) {
    double distance = Geolocator.distanceBetween(
      latitude,
      longitude,
      double.parse(station.address.latitude),
      double.parse(station.address.longitude),
    );

    if (nearestStation == null || distance < nearestStation.distance!) {
      nearestStation = station;
      nearestStation.distance = distance;
    }
  }

  return nearestStation!;
}
