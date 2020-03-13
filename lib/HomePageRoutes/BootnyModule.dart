import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glimpseapp_2/animation/FadeAnimation.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class BootnyModule extends StatefulWidget {
  @override
  _BootnyModuleState createState() => _BootnyModuleState();
}

class _BootnyModuleState extends State<BootnyModule> {
  final int delayedAmount = 500;
  List _outputs;
  File _image;
  bool _loading = false;
 // String f_name;

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
   //String f_name =  "${_outputs[0]["label"]}";
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      body: _loading
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
            _image == null
                ? Container(
              child: Text('Please select an image'),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: pickImage,
        child: Icon(Icons.image,color: Colors.black,),
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
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }



}
