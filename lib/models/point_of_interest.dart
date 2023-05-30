class POI {
  final String name;
  final double latitude;
  final double longitude;
  final String description;

  POI({required this.name, required this.latitude, required this.longitude, required this.description});

  factory POI.fromJson(Map<String, dynamic> json) {
    return POI(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      description: json['description'],
    );
  }
}
