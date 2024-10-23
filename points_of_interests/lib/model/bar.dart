class Bar {
  final String placeId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Bar({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // A factory constructor to create a Place object from JSON
  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
      placeId: json['placeId'] ?? '0',
      name: json['name'] ?? 'Unknown',
      address: json['vicinity'] ?? 'No address available',
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
    );
  }

  @override
  String toString() {
    return 'Bar(name: $name, address: $address, latitude: $latitude, longitude: $longitude)';
  }
}
