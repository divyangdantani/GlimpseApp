import 'package:flutter/material.dart';
import 'package:glimpseapp_2/animation/FadeAnimation.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';

class BarcodeModule extends StatefulWidget {
  @override
  _BarcodeModuleState createState() => _BarcodeModuleState();
}

class _BarcodeModuleState extends State<BarcodeModule> {
  final int delayedAmount = 500;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF8185E2),
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                      1.0,
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/light-1.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 150,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                      1.3,
                      Container(
                        //1.3 ,2.0
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/light-2.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 50,
                    top: 40,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                      1.8,
                      Container(
                        //1.5 ,3.0
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/glimpsy.png'))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DelayedAnimation(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Scan",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Any code will be decode",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    delay: delayedAmount + 1000,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

