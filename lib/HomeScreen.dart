import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to HomeScreen",
          style: TextStyle(
            color: Color.fromRGBO(143, 148, 251, 1),
            fontSize: 30.0
          ),
        ),
      ),
    );
  }
}
