import 'package:fluttertoast/fluttertoast.dart';
import 'package:glimpseapp_2/auth/authentication.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../SignUpScreen.dart';

class CarouselDemo extends StatefulWidget {
  CarouselDemo() : super();

  final String title = "Carousel Demo";
  @override
  CarouselDemoState createState() => CarouselDemoState();
}

class CarouselDemoState extends State<CarouselDemo> {
  //
  CarouselController buttonController = CarouselController();
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/images/nature.png',
    'assets/images/text.png',
    'assets/images/charater.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  //0xffea3869
  //#EA3869
  @override
  Widget build(BuildContext context) {
    var a;
    return Scaffold(
      backgroundColor: Color(0xff2b2d42),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 170),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    pauseAutoPlayOnTouch: true,
                    scrollDirection: Axis.horizontal,
                    //   onPageChanged: getBaba(),
                  ),
//
//              onPageChanged: () {
//                setState(() {
//                  _current = index;
//                };
//              }

                  carouselController: buttonController,
                  items: imgList.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Color(0xff2b2d42),
                          ),
                          child: Image.asset(
                            url,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: map<Widget>(imgList, (index, url) {
//                return Container(
//                  width: 10.0,
//                  height: 10.0,
//                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: _current == index ? Colors.redAccent : Colors.green,
//                  ),
//                );
//              }),
//            ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        focusColor: Colors.white,
                        highlightedBorderColor: Colors.white,
                        onPressed: goToPrevious,
                        child: Text(
                          "<",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      OutlineButton(
                        highlightedBorderColor: Colors.white,
                        onPressed: goToNext,
                        child: Text(
                          ">",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Text(
                      'Explore More...',
                      style: TextStyle(color: Color(0xffea3869)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Authentication()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToPrevious() {
    buttonController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToNext() {
    buttonController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}
