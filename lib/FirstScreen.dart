import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glimpseapp_2/auth/authentication.dart';
//import 'package:flutter/services.dart';
import 'package:glimpseapp_2/LoginScreen.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'HomeScreen.dart';
import 'SignUpScreen.dart';
//import 'package:glimpse_final/animation/FadeAnimation.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF8185E2),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white24,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 2),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: FlutterLogo(
                            size: 50.0,
                          ),
                          radius: 50.0,
                        )),
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Hi There",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: color,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 35.0,
//                      color: color),
                    ),
                    delay: delayedAmount + 1000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "I'm Glimpsy",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: color,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      fontSize: 35.0,
//                      color: color),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Your New Personal",
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "AI Vision",
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  DelayedAnimation(
                    child: GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpScreen()));
                      },
                      child: Transform.scale(
                        scale: _scale,
                        child: _animatedSignUpButtonUI,
                      ),
                    ),
                    delay: delayedAmount + 4000,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  DelayedAnimation(
                    child: GestureDetector(
                      child: Text(
                        "I already have an account",
//                    style: TextStyle(
//                        fontSize: 20.0,
//                        //fontWeight: FontWeight.bold,
//                        color: color),
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: color,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()));
                        //Navigator.pushNamed(context, "/");
                      },
                    ),
                    delay: delayedAmount + 5000,
                  ),

                  SizedBox(
                    height: 40.0,
                  ),
                  DelayedAnimation(
                    child: Text("OR",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: color,
                            fontWeight: FontWeight.bold)),
                    delay: delayedAmount + 6000,
                  ),

//Signup with google and facebook
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DelayedAnimation(
                        child: GestureDetector(
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTap: () async {
                            bool res = await loginWithGoogle();
                            if (!res) print('Error in logging with Google');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          },
                          child: Transform.scale(
                            scale: _scale,
                            child: _animatedGoogleButtonUI,
                          ),
                        ),
                        delay: delayedAmount + 6000,
                      ),
                      Padding(padding: EdgeInsets.only(left: 25)),
                      DelayedAnimation(
                        child: GestureDetector(
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
                                Authentication()));
                          },
                          child: Transform.scale(
                            scale: _scale,
                            child: _animatedOtpButtonUI,
                          ),
                        ),
                        delay: delayedAmount + 6000,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget get _animatedSignUpButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'Let me Sign Up',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      );

  Widget get _animatedGoogleButtonUI => Container(
        height: 50,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Icon(MdiIcons.google, size: 35, color: Colors.white,),
            //Image(image: AssetImage('assets/images/icons8-google-35.png')),
            Image.asset('assets/images/googleicon.png', height: 30, width: 30),
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Text(
              'Google',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );

  Widget get _animatedOtpButtonUI => Container(
    height: 50,
    width: 160,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Icon(MdiIcons.facebook, size: 40, color: Colors.white,),
        //Image(image: AssetImage('assets/images/icons8-facebook-35.png')),
        Image.asset('assets/images/otp.png',
            height: 32, width: 32),
        Padding(padding: EdgeInsets.only(left: 5.0)),
        Text(
          'OTP',
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    ),
  );


  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      if (res.user == null) return false;
      return true;
    } catch (e) {
      print('Error in logging with Google');
      return false;
    }
  }
}
