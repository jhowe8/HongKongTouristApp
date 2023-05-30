import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hkapp/widgets/tourist_map.dart';
import 'package:hkapp/models/point_of_interest.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';


class RegionPage extends StatefulWidget {
  final List<POI> pois;
  final String pageTitle;
  final double zoomLevel;

  RegionPage({required this.pois, required this.pageTitle, required this.zoomLevel});

  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  POI? selectedPoi;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Marker> markers = createMarkersForItems(widget.pois);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent),
      body: Container(
        width: screenWidth,
        height: max(MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyanAccent,
              Colors.blueAccent,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.pois.asMap().entries.map((entry) {
                int i = entry.key;
                String placeName = entry.value.name;
                String titleIndex = i != 0 ? '$i. ' : '';
                String title = '${titleIndex}$placeName';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,  // border color
                        width: 1.0,            // border width
                      ),
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(1.0),
                      color: Colors.blue,
                      child: Container(
                        width: screenWidth,
                        child: InkWell(
                            onTap: () => setState(() {
                              selectedPoi = widget.pois[i];
                            }),
                            child: Row(
                                children: [
                                  i != 0 ? Icon(
                                    Icons.place, // This is an example, you can choose any icon
                                    color: Colors.black,
                                  ) : Container(),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      title,
                                      textAlign: i != 0 ? TextAlign.start : TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: i != 0 ? 16.0 : 24.0,
                                      ),
                                    ),
                                  ),
                                ]
                            )
                        ),
                      ),
                    ),
                  )
                );
              }).toList(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
                child: TouristMap(latLng: LatLng(widget.pois[0].latitude, widget.pois[0].longitude), markers: markers, zoomLevel: widget.zoomLevel),
              ),
              if (selectedPoi != null)
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        '${selectedPoi?.description}',
                        style: TextStyle(color: Colors.white)
                    )
                ),
            ]
          )
        )
      )
    );
  }



  Marker createMarker(LatLng location, int i) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: location,
      builder: (ctx) => GestureDetector(
        onTap: () => launchGoogleMaps(location.latitude, location.longitude),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Colors.blueAccent,
                size: 50,
              ),
              Text(
                (i + 1).toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
      key: ValueKey(i),
    );
  }

  List<Marker> createMarkersForItems(List<POI> pois) {
    List<Marker> markers = [];
    for (var i = 1; i < pois.length; i++) {
      LatLng location = LatLng(pois[i].latitude, pois[i].longitude);
      markers.add(createMarker(location, i - 1));
    }
    return markers;
  }


  void launchGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}