import 'package:Technovatives/screens/Homepage/BarcodeScanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Technovatives/constants.dart';
import 'custom_button.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name, email, password;

  void getCurrentUser() async {
    try {
      FirebaseUser loggedinuser;
      final User = await _auth.currentUser();
      loggedinuser = User;
      if (User != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => barcodeApp()),
        );
      }
    } catch (e) {
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
      var height =
          MediaQuery
              .of(context)
              .size
              .height - MediaQuery
              .of(context)
              .padding
              .top;
      var space = height > 650 ? kSpaceM : kSpaceS;
      return MaterialApp(
        title: "Technovatives",
        home: Scaffold(
          body: Center(


            child: Padding(
              padding: const EdgeInsets.only(top: 250.0, left: 8.0, right: 8.0),

              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: <Widget>[

                    TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(kPaddingM),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: kBlack.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: kBlack.withOpacity(0.5),
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: space),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(kPaddingM),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: kBlack.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: kBlack.withOpacity(0.5),
                        ),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(height: space),
                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(kPaddingM),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: kBlack.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: kBlack.withOpacity(0.5),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: space),
                    CustomButton(
                      color: kBlue,
                      textColor: kWhite,
                      text: 'Register',
                      onPressed: () async {
                        try {
                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null) {
                            Firestore _firestore = Firestore.instance;
                            _firestore.collection('users').document(
                                newUser.user.uid).setData(
                                {
                                  "name": name,
                                  "email": email
                                }
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => barcodeApp()),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

