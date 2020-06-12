import 'package:flutter/services.dart';
import 'package:glimpseapp_2/FirstScreen.dart';
import 'package:glimpseapp_2/LoginScreen.dart';
import 'package:glimpseapp_2/SignUpScreen.dart';
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
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

//  Future<void> verifyNumber() async {
//    var connection = await Connectivity().checkConnectivity();
//
//    if (phoneNo == null) {
//      Fluttertoast.showToast(msg: "Please fill phone number");
//    } else {
//      final PhoneCodeSent smsCodeSent = (String verID, [int forceCodeResend]) {
//        this.verificationId = verID;
//       // Navigator.pop(context);
//        smsCodeDialog(context);
//      };
//      try {
//        await _auth.verifyPhoneNumber(
//            phoneNumber: this.phoneNo,
//            // PHONE NUMBER TO SEND OTP
//            codeAutoRetrievalTimeout: (String verId) {
//              //Starts the phone number verification process for the given phone number.
//              //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
//              this.verificationId = verId;
//            },
//            codeSent: smsCodeSent,
//            // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
//            timeout: const Duration(seconds: 20),
//            verificationCompleted: (AuthCredential phoneAuthCredential) async {
//              Fluttertoast.showToast(msg: "OTP Verified");
//              try {
//                final AuthCredential credential = PhoneAuthProvider.getCredential(
//                  verificationId: verificationId,
//                  smsCode: smsCode,
//                );
//                final FirebaseUser user =
//               await (_auth.signInWithCredential(credential)) as FirebaseUser;
//              final FirebaseUser currentUser = await _auth.currentUser();
//              assert(user.uid == currentUser.uid);
//              Navigator.of(context).pop();
//              Navigator.of(context).pushReplacementNamed('/homepage');
//              } catch (e) {
//              handleError(e);
//              }
//              //Navigator.of(context).pushReplacementNamed('/homepage');
//
//              print(phoneAuthCredential);
//            },
//            verificationFailed: (AuthException exceptio) {
//              if (connection != ConnectivityResult.mobile &&
//                  connection != ConnectivityResult.wifi) {
//                Fluttertoast.showToast(msg: "No internet connection");
//              } else {
//                Fluttertoast.showToast(msg: "Invalid number");
//              }
//              print('${exceptio.message}');
//            });
//      } catch (e) {
//        handleError(e);
//      }
//    }
//  }
  Future<void> verifyNumber() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Enter SMS code"),
              content: Container(
                height: 85,
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        this.smsCode = value;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    (errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container())
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  color: Colors.teal,
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _auth.currentUser().then((user) {
                      if (user != null) {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacementNamed('/homepage');
                      } else {
                        // Navigator.pop(context);
                        signIn();
                      }
                    });
                  },
                ),
              ],
            ));
  }

//  signIn() async {
//    try {
//      final AuthCredential credential = PhoneAuthProvider.getCredential(
//        verificationId: verificationId,
//        smsCode: smsCode,
//      );
//      final FirebaseUser user =
//          (await _auth.signInWithCredential(credential)) as FirebaseUser;
//      final FirebaseUser currentUser = await _auth.currentUser();
//      assert(user.uid == currentUser.uid);
//      Navigator.of(context).pop();
//      Navigator.of(context).pushReplacementNamed('/homepage');
//    } catch (e) {
//      handleError(e);
//    }
//  }
  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsCodeDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

//  handleError(PlatformException error) {
//    print(error);
//    switch (error.code) {
//      case 'ERROR_INVALID_VERIFICATION_CODE':
//        FocusScope.of(context).requestFocus(new FocusNode());
//        setState(() {
//          errorMessage = 'Invalid Code';
//        });
//        Navigator.of(context).pop();
//        smsCodeDialog(context);
//        break;
//      default:
//        setState(() {
//          errorMessage = error.message;
//        });
//
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b2d42),
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
                repeatPauseDuration: Duration(seconds: 0),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 9.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 80,
                        width: 80,
                      ),
                      radius: 60.0,
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
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
              delay: 1500,
            ),
            (errorMessage != ''
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 50.0,
            ),
            DelayedAnimation(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.white,
                onPressed: verifyNumber,
                child: Text(
                  "Send OTP",
                  style: TextStyle(color: Color(0xffea3869)),
                ),
              ),
              delay: 1000,
            ),
            SizedBox(height: 20),
            DelayedAnimation(
              child: Container(
                alignment: Alignment.center,
                  child: Text(
                'OR',
                style: TextStyle(color: Colors.white),
              )),
              delay: 1000,
            ),
            SizedBox(height: 20),
            DelayedAnimation(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignUpScreen()));
                },
                child: Text(
                  "Login via Email",
                  style: TextStyle(color: Color(0xffea3869)),
                ),
              ),
              delay: 1000,
            ),
            SizedBox(height: 40),
            DelayedAnimation(
              child: Container(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Text(
                    'Skip for now...',
                    style: TextStyle(
                      color: Color(0xffea3869),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreenModule()));
                  },
                ),
              ),
              delay: 3000,
            )
          ],
        ),
      ),
    );
  }
}
