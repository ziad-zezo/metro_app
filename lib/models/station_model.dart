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

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      json['line'],
      name: json['name'],
      address: Address(
        latitude: json['latitude'],
        longitude: json['longitude'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'line': line,
      'latitude': address.latitude,
      'longitude': address.longitude,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationModel && other.name == name && other.line == line;

  @override
  int get hashCode => Object.hash(name, line);
}

class Address {
  final String latitude;
  final String longitude;

  const Address({required this.latitude, required this.longitude});
}
