import 'package:aumpwa/widget/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: ListTile(
                onTap: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Authen(),
                          ),
                          (route) => false));
                },
                leading: Icon(
                  Icons.exit_to_app,
                  size: 36,
                  color: Colors.white,
                ),
                title: Text(
                  'Sign out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
