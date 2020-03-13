import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glimpseapp_2/HomePageRoutes/BarcodeModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/BootnyModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/ColorModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/ObjectDetectModule.dart';
import 'package:glimpseapp_2/HomePageRoutes/SpeakModule.dart';
import 'package:glimpseapp_2/LoginScreen.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  final int delayedAmount = 500;

  Items item1 = new Items(
      temp: 1,
      title: "Let's Speak",
      subtitle: "Don't bother about languages",
      event: "3 Events",
      img: "assets/images/speak.png");

  Items item2 = new Items(
    temp: 2,
    title: "Reveal the Nature",
    subtitle: "Know the plant families",
    event: "4 Items",
    img: "assets/images/plant.png",
  );

  Items item3 = new Items(
    temp: 3,
    title: "Describe Me",
    subtitle: "Labeling of an image",
    event: "",
    img: "assets/images/image.png",
  );

  Items item4 = new Items(
    temp: 4,
    title: "Color Patterns",
    subtitle: "Color identification",
    event: "",
    img: "assets/images/color.png",
  );

  Items item5 = new Items(
    temp: 5,
    title: "Scan",
    subtitle: "For any kind of barcode",
    event: "4 Items",
    img: "assets/images/barcode.png",
  );

  Items item6 = new Items(
    temp: 6,
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/images/settings.png",
  );

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xFFfffff;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return DelayedAnimation(
              child: Card(
                elevation: 15.0,
                child: GestureDetector(
                  onTap: () {
                    //detect(myList);
                    if (data.temp == 1) {
                     // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpeakModule()));
                    } else if (data.temp == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BootnyModule()));
                    } else if (data.temp == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ObjectDetectModule()));
                    } else if (data.temp == 4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ColorModule()));
                    } else if (data.temp == 5) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BarcodeModule()));
                    } else if (data.temp == 6) {
                      Fluttertoast.showToast(msg: "Coming Soon!!!");
                    }
//                    await _auth.signOut();
                    //Navigator.of(context).pushReplacementNamed('/loginpage');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 42,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Color(0xFF8185E2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Color(0xFF8185E2),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.event,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Color(0xFF8185E2),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              delay: delayedAmount + 2000,
            );
          }).toList()),
    );
  }
}

class Items {
  int temp;
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.temp, this.title, this.subtitle, this.event, this.img});
}
//detect(List<Items> myList){
//  switch(myList)
//  {
//    case myList.elementAt(0):
//
//  }
