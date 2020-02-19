import 'package:flutter/material.dart';
import 'package:glimpseapp_2/animation/delayed_anim.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  final int delayedAmount = 500;
  Items item1 = new Items(
      title: "Let's Speak",
      subtitle: "Don't bother about languages",
      event: "3 Events",
      img: "assets/images/speak.png");

  Items item2 = new Items(
    title: "Reveal the Nature",
    subtitle: "Know the plant families",
    event: "4 Items",
    img: "assets/images/plant.png",
  );
  Items item3 = new Items(
    title: "Describe Me",
    subtitle: "Labeling of an image",
    event: "",
    img: "assets/images/image.png",
  );
  Items item4 = new Items(
    title: "Color Patterns",
    subtitle: "Color identification",
    event: "",
    img: "assets/images/color.png",
  );
  Items item5 = new Items(
    title: "Scan",
    subtitle: "For any kind of barcode",
    event: "4 Items",
    img: "assets/images/barcode.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/images/settings.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff4527a0;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return DelayedAnimation(
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
                              color: Colors.white,
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
                              color: Colors.white38,
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
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              delay: delayedAmount + 1000,
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
