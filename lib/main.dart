import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glimpseapp_2/HomeScreen.dart';

void main(){ 
  runApp(MyApp());
  //SystemChrome.setEnabledSystemUIOverlays([]);
}
class MyApp extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: "GlimpseApp",
      debugShowCheckedModeBanner: false,
       home: HomeScreen()
    );
  }
}

