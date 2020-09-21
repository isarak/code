import 'package:aumpwa/widget/authen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  //MaterialApp usefull class material.
      //home: Text('PWA'), //home is propoties. 
      home: Authen(), //Authen is widget (Object)
    );
  }
}
