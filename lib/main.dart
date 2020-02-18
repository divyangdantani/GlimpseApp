import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glimpseapp_2/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glimpseapp_2/HomeScreen.dart';
import 'package:glimpseapp_2/LoginScreen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "GlimpseApp",
        debugShowCheckedModeBanner: false,
        home: FirstScreen());
  }
}

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.onAuthStateChanged,
//       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
//         if(snapshot.connectionState == ConnectionState.waiting)
//           return FirstScreen();
//         if(!snapshot.hasData || snapshot.data == null)
//           return LoginScreen();
//         return HomeScreen();
//       },
//     );
//   }
// }
