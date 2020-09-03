import 'package:Technovatives/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'cart.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore _firestore = Firestore.instance;

  void getCurrentUser() async {
    try{
      String uid;
      FirebaseAuth _auth = FirebaseAuth.instance;
      var height =
          MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
      final User =  await _auth.currentUser();
      if(User == null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(screenHeight: height,)),
        );
        uid = User.uid;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }


  Future<void> scanBarcodeNormal() async {
    String _scanBarcode;
    String barcodeScanRes;
    String name, image;
    int price;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", null , true, ScanMode.BARCODE);
      final document = _firestore.collection('products').document(barcodeScanRes);
      document.get().then((value) => {
        name = value.data['name'],
        image = value.data['image'],
        price = value.data['price'],
        AddToCart(name, image, price, barcodeScanRes),
      });
    } catch(e){
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void AddToCart(String name, String image,int price, String cid) async{
    Firestore __firestore = Firestore.instance;
    final _auth = FirebaseAuth.instance;

    final user = await _auth.currentUser();
    String id = user.uid;
    __firestore.collection('users').document(id).collection('cart_items').document(cid)
        .setData({
      "name":name,
      "image":image,
      "price":price,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => CartApp()));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text('Barcode scan')),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Text("Start barcode scan")),
                  ]));
        }));
  }
}

