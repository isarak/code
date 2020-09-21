import 'package:aumpwa/widget/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  //get data push data
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;

  //create state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 3,
            colors: [Colors.white, Colors.blue],
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
        onPressed: () {},
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
}
