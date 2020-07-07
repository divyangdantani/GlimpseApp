import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glimpseapp_2/animation/FadeAnimation.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'ColorPickerWidget.dart';

class ColorModule extends StatefulWidget {
  @override
  _ColorModuleState createState() => _ColorModuleState();
}

class _ColorModuleState extends State<ColorModule> {
  final int delayedAmount = 500;
  File pickedImage;
  bool isImageLoaded = false;
  Color pickColor = Color(0xFF8185E2);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff2b2d42),
        body: SingleChildScrollView(
          child: Column(
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
                      width: 100,
                      height: 200,
                      child: FadeAnimation(
                        1.8,
                        Container(
                          //1.5 ,3.0
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/logo.png'))),
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
                            "Color Pattern",
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
                            "Color Identification",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
//                          Container(
//                            height: 30,
//                            width: 140,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(100.0),
//                              color: Colors.white,
//                            ),
//
//                          ),
                        ],
                      ),
                      delay: delayedAmount + 1000,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
//             isImageLoaded ? Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: FileImage(pickedImage), fit: BoxFit.fitHeight),
//               ),
//             )
                  DelayedAnimation(
                child: Container(
                  color: Colors.white60,
                  child: new ColorPicker(
                    color: Colors.white,

                    onChanged: (value) {
                      setState(() {
                        pickColor = value;
                      });
                    },
                  ),
                ),
                delay: delayedAmount + 1000,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.image,
            color: Colors.black,
          ),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ColorPickerWidget()));},
//          onPressed: () {
//            pickImage(context);
//          },
        ),
      ),
    );
  }

  Future pickImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose From"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(12.0)),
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openCamera(BuildContext context) async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    if (tempStore != null) {
      setState(() {
        pickedImage = tempStore;
        isImageLoaded = true;
      });
    } else {
      Fluttertoast.showToast(msg: 'Please select an image');
    }
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (tempStore != null) {
      setState(() {
        pickedImage = tempStore;
        isImageLoaded = true;
      });
    } else {
      Fluttertoast.showToast(msg: 'Please select an image');
    }
    Navigator.of(context).pop();
  }
}
