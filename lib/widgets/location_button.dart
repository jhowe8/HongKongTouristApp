import 'package:flutter/material.dart';


class LocationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String buttonText;
  final int dayNumber;

  LocationButton({required this.onPressed, required this.imagePath, required this.buttonText, required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.8;
    final buttonHeight = buttonWidth * 0.2;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                          children: [
                            Text(
                              'Day ${dayNumber}',
                              style: TextStyle(
                                fontSize: 12,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.black,
                              ),
                            ),
                            Text(
                              'Day ${dayNumber}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ]
                      ),
                      Stack(
                        children: [
                          Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 24,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ]
                      )
                    ]
                  )
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
