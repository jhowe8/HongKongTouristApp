import 'package:hkapp/models/point_of_interest.dart';


class Region {
  final String name;
  final String alternateName;
  final List<POI> pois;
  final double zoomLevel;

  Region({required this.name, required this.alternateName, required this.pois, required this.zoomLevel});

  factory Region.fromJson(Map<String, dynamic> json) {
    var poisJson = json['pois'] as List;
    List<POI> poisList = poisJson.map((i) => POI.fromJson(i)).toList();

    return Region(
      name: json['name'],
      alternateName: json['alternateName'],
      zoomLevel: json['zoomLevel'],
      pois: poisList,
    );
  }
}