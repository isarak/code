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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildContainer(),
              buildText(),
              userText(),
              passwordText(),
            ],
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
            suffixIcon:
                IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                }),),
      ),
    );
  }

  Text buildText() => Text(
        'UNPLAN',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                fontSize: 30,
                color: Colors.blue[300],
                fontWeight: FontWeight.bold)),
      );

  Container buildContainer() {
    return Container(
      width: 250,
      child: Image.asset('images/travel.png'),
    );
  }
}
