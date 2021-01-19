import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/utils/screen_utils.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'Comman/circular_progress_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  User user;
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    isLoginOrNOt();
  }

  void isLoginOrNOt() async {
    user = await FirebaseAuth.instance.currentUser;
    setState(() {
      if (user != null) {
        isLogin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${(isLogin) ? user.displayName : ""}"),
      ),
      body: (!isLogin)
          ? Container(
              child: screenProgressIndicator,
            )
          : Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(user.photoURL),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter),
                      ),
                      child: null,
                    ),
                    setUserData(
                        icon: Icons.account_circle_rounded,
                        data: user.displayName),
                    // if (user.phoneNumber.isNotEmpty)
                    if (user.phoneNumber != null)
                      setUserData(icon: Icons.phone, data: user.phoneNumber),
                    setUserData(icon: Icons.email, data: user.email),
                    if (user != null)
                      SignInButtonBuilder(
                          text: 'Sign Out',
                          icon: Icons.logout,
                          onPressed: () {
                            _logOut();
                          },
                          backgroundColor: Colors.blueGrey[700]),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      Navigator.pop(context);
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget setUserData({String data, IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "$data",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
