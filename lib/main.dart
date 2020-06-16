import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glimpseapp_2/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glimpseapp_2/HomePageRoutes/BarcodeModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/BootnyModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/ColorModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/ObjectDetectModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/SpeakModule.dart';
import 'package:glimpseapp_2/HomeScreen.dart';
import 'package:glimpseapp_2/HomeScreenModule.dart';
import 'package:glimpseapp_2/LoginScreen.dart';

import 'HomePageRoutes/caro.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
       // title: "GlimpseApp",
        routes: <String, WidgetBuilder>{
          '/homepage': (BuildContext context) => HomeScreenModule(),
          '/loginpage': (BuildContext context) => LoginScreen(),
          '/Speak': (BuildContext context) => SpeakModule(),
          '/Bootny': (BuildContext context) => BootnyModule(),
          '/ObjectDetection': (BuildContext context) => ObjectDetectModule(),
          '/ColorModule': (BuildContext context) => ColorModule(),
          '/Barcode': (BuildContext context) => BarcodeModule(),
        },
        debugShowCheckedModeBanner: false,
        home:  CarouselDemo());
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
