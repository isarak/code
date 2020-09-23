import 'package:flutter/material.dart';

Future<Null> normalDailog(BuildContext contexts, String str, int mode) async {
  showDialog(
    context: contexts,
    builder: (contexts) => SimpleDialog(
      title: ListTile(
        leading: Container(
          width: 60,
          child: Image.asset('images/travel.png'),
        ),
        title: Text('Validate Data!!'),
        subtitle: Text(str),
      ),
      children: [
        FlatButton(
          onPressed: () => Navigator.pop(contexts),
          child: Text('OK'),
        )
      ],
    ),
  );
}
