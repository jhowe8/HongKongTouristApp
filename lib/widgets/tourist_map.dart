import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class TouristMap extends StatelessWidget {
  final LatLng latLng;
  final List<Marker> markers;
  final double zoomLevel;

  TouristMap({required this.latLng, required this.markers, required this.zoomLevel});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return(
      FittedBox(
        child: Container(
        width: screenWidth,
        height: screenHeight * 0.5,
        child: FlutterMap(
          options: MapOptions(
            center: this.latLng,
            zoom: zoomLevel,
            minZoom: zoomLevel
          ),
          nonRotatedChildren: [],
          children: [
            TileLayer(
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(markers: this.markers),
          ],
        )
        )
      )
    );
  }
}
