import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  //get data push data
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //create state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(width: 250,
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
