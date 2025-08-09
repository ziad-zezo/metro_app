class StationModel {
  final String name;
  final Address address;
  final String line;
  double? distance;
  StationModel(
    this.line, {
    required this.name,
    required this.address,
    this.distance,
  });
}

class Address {
  final String latitude;
  final String longitude;

  const Address({required this.latitude, required this.longitude});
}
