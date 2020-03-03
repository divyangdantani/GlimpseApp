import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glimpseapp_2/HomeScreenModule.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String phoneNo;
  String smsCode;
  String verificationId;


  Future<void> verifyNumber() async {
    var connection = await Connectivity().checkConnectivity();

    if (phoneNo == null) {
      Fluttertoast.showToast(msg: "Please fill phone number");
    }
    else {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
        this.verificationId = verID;

        ///Dialog here
        smsCodeDialog(context);
      };

      final PhoneCodeSent smsCodeSent = (String verID, [int forceCodeResend]) {
        this.verificationId = verID;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreenModule()));
      };
      final PhoneVerificationCompleted verificationSuccess =
          (AuthCredential credential) {
        Fluttertoast.showToast(msg: "OTP Verified");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreenModule()));
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException exception) {
        if (connection != ConnectivityResult.mobile &&
            connection != ConnectivityResult.wifi) {
          Fluttertoast.showToast(msg: "No internet connection");
        } else {
          Fluttertoast.showToast(msg: "Invalid number");
        }
        print('${exception.message}');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          codeAutoRetrievalTimeout: autoRetrieve,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationSuccess,
          verificationFailed: verificationFailed);
    }
  }

    Future<bool> smsCodeDialog(BuildContext context) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text("Enter SMS code"),
                content: TextField(onChanged: (value) {
                  this.smsCode = value;
                }),
                actions: <Widget>[
                  RaisedButton(
                    color: Colors.teal,
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreenModule()));
                        } else {
                          Navigator.pop(context);
                          signIn();
                        }
                      });
                    },
                  )
                ],
              ));

  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreenModule()));
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            DelayedAnimation(
              child: AvatarGlow(
                endRadius: 100,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 9.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: FlutterLogo(
                        size: 50.0,
                      ),
                      radius: 50.0,
                    )),
              ),
              delay: 1500,
            ),
            SizedBox(
              height: 50.0,
            ),
            DelayedAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OTP Verification",
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
                    "Enter phone number",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              delay: 1000,
            ),
            SizedBox(
              height: 10.0,
            ),
            DelayedAnimation(
              child: TextField(
                controller: TextEditingController(text: '+91 '),
                textAlign: TextAlign.start,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  hintStyle: TextStyle(color: Colors.white),
                ),keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
              delay: 1500,
            ),
            SizedBox(
              height: 50.0,
            ),
            DelayedAnimation(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.white,
                onPressed: verifyNumber,
                child: Text(
                  "Send OTP",
                  style: TextStyle(color: Color(0xFF8185E2)),
                ),
              ),
              delay: 1000,
            )
          ],
        ),
      ),
    );
  }
}
