import 'package:aumpwa/utility/normal_dialog.dart';
import 'package:aumpwa/widget/my_service.dart';
import 'package:aumpwa/widget/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  //get data push data
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  String user = '', password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkStatus();
  }

  //create state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 5,
            colors: [Colors.white, Colors.lightBlue],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildContainer(),
                buildText(),
                userText(),
                passwordText(),
                loginbutton(),
                registerbutton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton registerbutton() => FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
        child: Text(
          'Create New User',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
      );

  Container loginbutton() {
    return Container(
      width: 250,
      height: 45,
      margin: EdgeInsets.only(top: 16),
      child: RaisedButton(
        color: Colors.lightBlue[700],
        onPressed: () async {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: user, password: password)
              .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyService(),
                  ),
                  (route) => false))
              .catchError((value) {
            String error = value.message;
            normalDailog(context, error, 6);
          });
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container userText() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'User :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container passwordText() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 250,
      height: 40,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
          labelText: 'Password :',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              }),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'UNPLAN',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                fontSize: 40,
                color: Colors.lightBlue[700],
                fontWeight: FontWeight.bold)),
      );

  Container buildContainer() {
    return Container(
      width: 250,
      child: Image.asset('images/travel.png'),
    );
  }

  Future<Null> checkStatus() async {
    await Firebase.initializeApp().then((value) async {
      try {
        await FirebaseAuth.instance.authStateChanges().listen((event) {
          if (event != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyService(),
                ),
                (route) => false);
          }
        });
      } catch (e) {
        normalDailog(context, 'Network error', 6);
      }
    });
  }
}
