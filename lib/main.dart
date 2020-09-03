import 'package:Technovatives/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:page_transition/page_transition.dart';
import 'intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:Technovatives/screens/Homepage/BarcodeScanner.dart';

void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: MyApp(), 2: MyApp()};

  runApp(MaterialApp(
    home: CustomSplash(
      imagePath: 'assets/images/tech_circle.png',
      backGroundColor: Colors.white,
      animationEffect: 'zoom-out',
      logoSize: 180,
      home: MyApp(),
      customFunction: duringSplash,
      duration: 3500,
      type: CustomSplashType.StaticDuration,
      outputAndHome: op,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Login(screenHeight: height,)));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new App()));
    }
  }


  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

