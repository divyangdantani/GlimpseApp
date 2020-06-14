import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glimpseapp_2/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glimpseapp_2/HomeScreenModule.dart';
import 'package:glimpseapp_2/animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _email, _password;

  Future<void> _signIn() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _loginCommand();

      //firebase authentication
      try {
        //TODO: change AuthResult to FirebaseUser
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        //TODO: Navigate to HomeScreen
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreenModule()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void _loginCommand() {
    final snackbar = SnackBar(
      content: Text('Email: $_email, Password: $_password'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xff2b2d42),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  )),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                            1.0,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            ),
                          )),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            //1.3 ,2.0
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                          1.5,
                          Container(
                            //1.5 ,3.0
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          ),
                        ),
                      ),
                      Positioned(
                          child: FadeAnimation(
                        1.6,
                        Container(
                          // 3.5
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Container(
                          //1.8 , 4.0
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (val) =>
                                          !EmailValidator.Validate(val, true)
                                              ? 'Not a valid email.'
                                              : null,
                                      onSaved: (val) => _email = val,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (val) => val.length < 8
                                          ? 'Password too short..'
                                          : null,
                                      onSaved: (val) => _password = val,
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2.0,
                          GestureDetector(
                            child: Container(
                              //2 , 4.5
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: _signIn,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          GestureDetector(
                            child: Text("Forgot Password?", //1.5 , 3.5
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                )),
//                            onTap: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          HomeScreenModule()));
                            //},
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void toastMessage() {
    Fluttertoast.showToast(
        msg: "Tari Bhul...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        //backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
