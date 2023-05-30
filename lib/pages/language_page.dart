import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'home.dart';


class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Select Language'), backgroundColor: Colors.cyanAccent),
      body: Center(
        child: Container(
          width: screenWidth,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,  // set it to min
                  children: [
                    Flag.fromCode(FlagsCode.GB, height: 50, width: 50),
                    SizedBox(width: 10),
                    Text('English', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(title: 'Hong Kong Tourist App', language: 'EN'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey,
                  side: BorderSide(color: Colors.black, width: 1),
                  elevation: 3,
                  minimumSize: Size(175, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,  // set it to min
                  children: [
                    Flag.fromCode(FlagsCode.CN, height: 50, width: 50),
                    SizedBox(width: 10),
                    Text('中文', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(title: 'Hong Kong Tourist App', language: 'CN'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey,
                  side: BorderSide(color: Colors.black, width: 1),
                  elevation: 3,
                  minimumSize: Size(175, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}