import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
        child: Column(
          children: <Widget>[
            Text(
              "Welcome to HomeScreen",
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontSize: 30.0
              ),
            ),
            RaisedButton(
              child: Text("Log Out"),
              onPressed: logOut
            )
          ],
        ),
      ),

    );
  }

 final FirebaseAuth _auth = FirebaseAuth.instance;
 Future<void> logOut() async{
   try{
   await _auth.signOut();
   }
   catch(e){
     print('Error in Logging Out');
   }
 }

}
