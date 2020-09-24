import 'package:aumpwa/models/user_model.dart';
import 'package:aumpwa/utility/constant.dart';
import 'package:aumpwa/utility/normal_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ReadQR extends StatefulWidget {
  @override
  _ReadQRState createState() => _ReadQRState();
}

class _ReadQRState extends State<ReadQR> {
  String uidlogin = 'imwilFMzblVPRcNwLKkv04S6RiE2';
  String qrResult;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData(uidlogin);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => processReadQRcode(),
        child: Icon(Icons.add_to_queue),
      ),
      body: userModel == null ? Center(child: Text('Please scan QR Code')) : buildColumnRead(),
    );
  }

  buildColumnRead() {
    return Center(
      child: Column(
        children: [
          //Text('uID : $qrResult'),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: 200,
            height: 200,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userModel.path),
            ),
            //child: Image.network(userModel.path),
          ),
          Text('Name : ${userModel.name}'),
          Text('Position : ${userModel.position}'),
          Text('lattitude : ${userModel.lat}'),
          Text('Logitude : ${userModel.long}'),
          OutlineButton(onPressed: () => processUploadMySQl() ,child: Text('upload Data to mySQL'),)
        ],
      ),
    );
  }
  
  Future<Null> readData(String uid) async{
    await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('UserAum')
            .doc(uid)
            .snapshots()
            .listen((event) {
          setState(() {
            userModel = UserModel.fromJson(event.data());
          });
        });

        print('${userModel.name}');
      });
  }

  Future<Null> processReadQRcode() async {
    try {
      var result = await BarcodeScanner.scan();
      qrResult = result.rawContent;
      

      await readData(qrResult);

    } catch (e) {
      print(e);
    }
  }

  Future<Null> processUploadMySQl()async{
    String urlAPI = '${Constant().domain}/pwa/addFriend.php?isAdd=true&uidLogin=$uidlogin&uidFriend=$qrResult&nameFriend=${userModel.name}&position=${userModel.position}&urlPath=${userModel.path}&lat=${userModel.lat}&lng=${userModel.long}';
    await Dio().get(urlAPI).then((value) => normalDailog(context, 'Upload success.', 8));
  }
}
