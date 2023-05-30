import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hkapp/pages/region_page.dart';
import '../models/region.dart';
import '../widgets/location_button.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String language;

  const HomePage({super.key, required this.language, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Region>> loadRegionsFromJson() async {
    String jsonString = await rootBundle.loadString('assets/regions${widget.language}.json');
    List<dynamic> jsonRegions = jsonDecode(jsonString)['regions'];

    return jsonRegions.map((json) => Region.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hong Kong Travel App'), backgroundColor: Colors.cyanAccent,),
        body: FutureBuilder<List<Region>>(
          future: loadRegionsFromJson(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: snapshot.data!.map((region) {
                        return LocationButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegionPage(pois: region.pois, pageTitle: region.alternateName, zoomLevel: region.zoomLevel))
                            );
                          },
                          imagePath: 'assets/' + region.name + '.png',
                          buttonText: region.alternateName,
                        );
                      }).toList(),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}