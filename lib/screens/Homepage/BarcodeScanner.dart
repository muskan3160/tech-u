import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Technovatives/screens/login/login.dart';

import 'sidebar/sidebar_layout.dart';
void main() => runApp(
    MaterialApp(
      home: barcodeApp(),
    )
);

class barcodeApp extends StatefulWidget {
  @override
  _barcodeState createState() => _barcodeState();
}

class _barcodeState extends State<barcodeApp> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String uid;
  void getCurrentUser() async{
    try{
      var height =
          MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
      final User =  await _auth.currentUser();
      if(User == null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(screenHeight: height,)),
        );
      }
      uid = User.uid;
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
      ),
      home: SideBarLayout(),
    );
  }
}