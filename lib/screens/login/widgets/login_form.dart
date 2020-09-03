import 'package:Technovatives/screens/login/widgets/RegisterForm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Technovatives/constants.dart';
import 'package:Technovatives/screens/login/widgets/custom_button.dart';
import 'package:Technovatives/screens/login/widgets/fade_slide_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Technovatives/screens/Homepage/BarcodeScanner.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  final Animation<double> animation;
  LoginForm({
    @required this.animation,
  }) : assert(animation != null);
}

class _LoginFormState extends State<LoginForm> {
  FirebaseUser loggendinuser;
  String email,password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async{
    try{
      final User = await _auth.currentUser();
      loggendinuser = User;
      if(User != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => barcodeApp()),
        );
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
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,
            child: TextField(
              onChanged: (value){
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
                  Icons.person,
                  color: kBlack.withOpacity(0.5),
                ),
              ),
              obscureText: false,
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child: TextField(
              onChanged: (value){
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
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 2 * space,
            child: CustomButton(
              color: kBlue,
              textColor: kWhite,
              text: 'Login to continue',
              onPressed: () async{
                try{
                  final newUser = await _auth.signInWithEmailAndPassword(email: email, password:password);
                  if(newUser != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>barcodeApp ()),
                    );
                  }
                }catch(e){
                  print(e);
                }
              },
            ),
          ),
          SizedBox(height: 2 * space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 4 * space,
            child: CustomButton(
              color: kBlack,
              textColor: kWhite,
              text: 'Create a Technovatives Account',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterForm())
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

