import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../welcome_screen.dart';

void pageChanger(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
}
