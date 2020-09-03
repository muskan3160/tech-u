import 'package:flutter/material.dart';

import 'package:Technovatives/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (BuildContext context) {
          var screenHeight = MediaQuery.of(context).size.height;
          return Onboarding(
            screenHeight: screenHeight,
          );
        },
      ),
    );
  }
}

void main() => runApp(App());
