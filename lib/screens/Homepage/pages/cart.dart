import 'package:Technovatives/screens/Homepage/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:Technovatives/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(
  MaterialApp(
    home: CartApp(),
  )
);
class CartApp extends StatefulWidget with NavigationStates{
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp>{
  FirebaseUser user;
  String error;

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }
  void getCurrentUser() async {
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      var height =
          MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
      final User =  await _auth.currentUser();
      if(User == null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(screenHeight: height,)),
        );
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Cart",
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: height / 1.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('users').document(user.uid).collection('cart_items').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Card(
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset(
                                "${document.data['image']}",
                              ),
                              title: Text("${document.data['name']}"),
                              subtitle: Text("₹ ${document.data['price']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    Firestore.instance
                                        .collection('users')
                                         .document(user.uid).collection("cart_items")
                                        .document(document.documentID)
                                        .delete();
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Item Deleted From Cart",
                                      toastLength: Toast.LENGTH_LONG);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Container(
                      child: Text('Nothing here !'),
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                color: Color(0xFFB33771),
                minWidth: MediaQuery.of(context).size.width,
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Proceed to Buy",
                  style: _btnStyle(),
                ),
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _btnStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

