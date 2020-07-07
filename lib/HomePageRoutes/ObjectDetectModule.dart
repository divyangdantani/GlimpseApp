import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glimpseapp_2/animation/FadeAnimation.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ObjectDetectModule extends StatefulWidget {
  @override
  _ObjectDetectModuleState createState() => _ObjectDetectModuleState();
}

class _ObjectDetectModuleState extends State<ObjectDetectModule> {
  final int delayedAmount = 500;

  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
        //  f_name =  "${_outputs[0]}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff2b2d42),
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
                          "Face Detection",
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
                          "Labeling of Famous Celebrity",
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
            ),
            _loading
                ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,

              ),
            )
                : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  _image == null
                      ? Container(
                    child: Text('Please select an image of celebrity..',style: TextStyle(color: Colors.white),),
                  )
                      : Image.file(_image),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ?
                  Text(
                    "${_outputs[0]["label"]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()..color = Colors.white,
                    ),
                  )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  _image != null
                      ? Container(
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                        child: Text('Facts to know about '+  "${_outputs[0]["label"]}".substring(2)),
                        onPressed: _launchURL,
                      ))
                      : Container(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: pickImage,
          child: Icon(Icons.image,color: Colors.black,),
        ),
      ),
    );
  }


  _launchURL() async {
    //const url = 'https://flutter.dev';
    String flower = _outputs[0]["label"];
    String name = flower.substring(2);
//    setState(() {
//      f_name=name;
//    });
    print(name);
    String url = "https://en.wikipedia.org/wiki/" + name;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant1.tflite",
      labels: "assets/labels1.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }



}
