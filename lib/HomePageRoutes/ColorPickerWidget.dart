import 'dart:async';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  String imagePath = 'assets/images/demo1.jpeg';
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();
  Io.File pickedImage;
  bool isImageLoaded = false;
  AnimationController _controller;
  bool useSnapshot = true;

  GlobalKey currentKey;

  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image photo;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final String title = useSnapshot ? "snapshot" : "basic";
    return Scaffold(
//      appBar: AppBar
      backgroundColor: Color(0xFF8185E2),
      body: StreamBuilder(
          initialData: Colors.green[500],
          stream: _stateController.stream,
          builder: (buildContext, snapshot) {
            Color selectedColor = snapshot.data ?? Colors.green;
            return Stack(
              children: <Widget>[
            Container(
                  margin: EdgeInsets.only(left: 45, top: 135),
                  child: Text(
                    "Please Select any pixel from demo image",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                isImageLoaded
                    ? RepaintBoundary(
                        key: paintKey,
                        child: GestureDetector(
                          onPanDown: (details) {
                            searchPixel(details.globalPosition);
                          },
                          onPanUpdate: (details) {
                            searchPixel(details.globalPosition);
                          },
                          child: Center(
                            child: Image.file(
                              pickedImage,
                              key: imageKey,
                              //color: Colors.red,
                              //colorBlendMode: BlendMode.hue,
                              //alignment: Alignment.bottomRight,
                              fit: BoxFit.fill,
                              //scale: .8,
                            ),
                          ),
                        ),
                      )

                    : RepaintBoundary(
                        key: paintKey,
                        child: GestureDetector(
                          onPanDown: (details) {
                            searchPixel(details.globalPosition);
                          },
                          onPanUpdate: (details) {
                            searchPixel(details.globalPosition);
                          },
                          child: Center(
                            child: Image.asset(
                              imagePath,
                              key: imageKey,
                              //color: Colors.red,
                              //colorBlendMode: BlendMode.hue,
                              //alignment: Alignment.bottomRight,
                              fit: BoxFit.fill,
                              //scale: .8,
                            ),
                          ),
                        ),
                      ),
                Container(
                  margin: EdgeInsets.only(left: 95, top: 185),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedColor,
                      border: Border.all(width: 5.0, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ]),
                ),
                Positioned(
                  child: Text('${selectedColor}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          backgroundColor: Colors.black54)),
                  left: 160,
                  top: 200,
                ),
                GestureDetector(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Try other images',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 70, top: 600),
                    height: 60,
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.white,
                    ),
                  ),
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: () {
                    pickImage(context);
                  },
                ),
              ],
            );
          }),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await (useSnapshot ? loadSnapshotBytes() : loadImageBundleBytes());
    }
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    _stateController.add(Color(hex));
  }

  Future<void> loadImageBundleBytes() async {

    if(isImageLoaded == true){
      ByteData imageBytes = (await Io.File(pickedImage.toString()).readAsBytes()) as ByteData;
      setImageBytes(imageBytes);
    }
    else{
    ByteData imageBytes = await rootBundle.load(imagePath);
    setImageBytes(imageBytes);
    }
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
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

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
