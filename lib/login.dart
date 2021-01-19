import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/utils/page_route.dart';
import 'package:flutter_auth_firebase/utils/screen_utils.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'AllSignIn/all_sign_in_methods.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    initApp();
    isLoginOrNOt();
  }

  void isLoginOrNOt() async {
    User user = await FirebaseAuth.instance.currentUser;
    if (user != null) pageChanger(context);
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    // immediately check whether the user is signed in
  }

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.Google,
              onPressed: () {
                signInWithGoogle(
                    auth: _auth, googleSignIn: _googleSignIn, context: context);
              },
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: () {
                signInWithFacebook(auth: _auth, context: context);
              },
            ),
            /*  SignInButtonBuilder(
                text: 'Sign in with Email',
                icon: Icons.email,
                onPressed: () {},
                backgroundColor: Colors.blueGrey[700]),*/
          ],
        ),
      ),
    );
  }
}
