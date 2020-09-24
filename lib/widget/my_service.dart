import 'package:aumpwa/models/user_model.dart';
import 'package:aumpwa/widget/authen.dart';
import 'package:aumpwa/widget/listFriend.dart';
import 'package:aumpwa/widget/readQR.dart';
import 'package:aumpwa/widget/showQR.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Declare Variable
  String uidLogin, name, email ;
  UserModel userModel;
  Widget currentWidget = ListFriend();
  List<String> titles = ['List Friends','Show QR Code','Read QR Code'];
  int indexTitle = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLogin();
  }

  Future<Null> findLogin() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      uidLogin = event.uid;
      email = event.email;
      findDetailLogin();
    });
  }

  Future<Null> findDetailLogin() async {
    await FirebaseFirestore.instance
        .collection('UserAum')
        .doc(uidLogin)
        .snapshots()
        .listen((event) {
      setState(() {
        userModel = UserModel.fromJson(event.data());
      });
    }); //listen is fetch data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[indexTitle]),),
      drawer: buildDrawer(),
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildUserAccountsDrawerHeader(),
              listfriends(),
              showqr(),
              readqr(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile listfriends() {
    return ListTile(
      onTap: (){
        Navigator.pop(context);
        setState(() {
          currentWidget = ListFriend();
          indexTitle = 0;
        });
      },
      leading: Icon(
        Icons.library_books,
        size: 36,
      ),
      title: Text('List Friend'),
      subtitle: Text('Show name of your friends.'),
    );
  }

  ListTile showqr() {
    return ListTile(
      onTap: (){
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowQR(uid: uidLogin,);//send data to showQR
          indexTitle = 1;
        });
      },
      leading: Icon(
        Icons.border_clear,
        size: 36,
      ),
      title: Text('Show QR Code'),
      subtitle: Text('Show your QR Code.'),
    );
  }

  ListTile readqr() {
    return ListTile(
      onTap: (){
        Navigator.pop(context);
        setState(() {
          currentWidget = ReadQR();
          indexTitle = 2;
        });
      },
      leading: Icon(
        Icons.border_outer,
        size: 36,
      ),
      title: Text('Read QR Code'),
      subtitle: Text('Read QR Code.'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/island.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      arrowColor: Colors.white,
      accountName:
          Text(userModel == null ? 'Name' : 'Name : ${userModel.name}'),
      accountEmail: Text(
          userModel == null ? 'Position' : 'Position : ${userModel.position}'),
      currentAccountPicture: userModel == null
          ? CircleAvatar(
              backgroundImage: AssetImage('images/user.png'),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(userModel.path),
            ),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.redAccent),
          child: ListTile(
            onTap: () {
              processSignOut();
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
    );
  }

  Future<Null> processSignOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Authen(),
            ),
            (route) => false));
  }
}
