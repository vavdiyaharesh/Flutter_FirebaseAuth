import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/utils/page_route.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Void> signInWithGoogle(
    {FirebaseAuth auth,
    GoogleSignIn googleSignIn,
    BuildContext context}) async {
  User user;

  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  user = (await auth.signInWithCredential(credential)).user;
  print("$user");

  if (user != null) pageChanger(context);
}

Future<Void> signInWithFacebook(
    {FirebaseAuth auth, BuildContext context}) async {
  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  final AccessToken accessToken = await FacebookAuth.instance.isLogged;

  if (accessToken != null) {
    print("is Logged:::: ${(accessToken.toJson())}");
    final userData = await FacebookAuth.instance.getUserData();
    _accessToken = accessToken;
    _userData = userData;
  } else {
    try {
      _accessToken = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } on FacebookAuthException catch (e) {
      print(e.message);
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
  final OAuthCredential credential =
      FacebookAuthProvider.credential(_accessToken.token);
  final User user = (await auth.signInWithCredential(credential)).user;

  if (user != null) pageChanger(context);
}
