import 'package:aumpwa/widget/authen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      //MaterialApp usefull class material.
      //home: Text('PWA'), //home is propoties.
      title: 'UNPLAN',
      debugShowCheckedModeBanner: false,
      home: Authen(), //Authen is widget (Object)
    );
  }
}
