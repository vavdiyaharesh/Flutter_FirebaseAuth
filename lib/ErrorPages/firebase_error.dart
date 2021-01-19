import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/utils/screen_utils.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class ErrorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ErrorHomePage(title: 'Firebase Auth in Flutter '),
    );
  }
}

class ErrorHomePage extends StatefulWidget {
  ErrorHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ErrorHomePageState createState() => _ErrorHomePageState();
}

class _ErrorHomePageState extends State<ErrorHomePage> {
  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButtonBuilder(
                text: 'Try Again',
                icon: Icons.report,
                onPressed: () {},
                backgroundColor: Colors.blueGrey[700]),
          ],
        ),
      ),
    );
  }
}
