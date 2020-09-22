import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> positions = [
    // List<type> is array
    'Computer technicial',
    'Manager',
    'Administrator',
    'Accounting',
    'Finacial',
    'Officer',
  ];

  String choosePositon; //defualt is null
  double lat, long; //defualt is null
  File file; // select import dart.io

  @override
  void initState() {
    // initState is first run.
    // in debug mode press R to run initState
    super.initState();
    findLatlng();
  }

  Future<Null> findLatlng() async {
    LocationData locationData = await findLocation();
    setState(() {
      lat = locationData.latitude;
      long = locationData.longitude;
      print('lat = $lat,lng=$long');
    });
  }

  Future<LocationData> findLocation() async {
    Location location = Location(); //Location is class of package location
    try {
      return await location
          .getLocation(); //await is watting for complete command.
    } catch (e) {
      print('Can not load location. error code ==>${e.toString()}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // appBar is show bar on apps.
      body: SingleChildScrollView(
        //SingleChildScrollView is Scroll View
        child: Column(
          children: [
            buildAvatar(),
            buildName(),
            SizedBox(
              height: 10,
            ), // Create for Space like magin
            buildPosition(),
            buildUser(),
            buildPassword(),
            lat == null ? CircularProgressIndicator() : buildMap(), //shot if
          ],
        ),
      ),
    );
  }

  Set<Marker> mySet() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myID'),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          title: 'You are here.',
          snippet: 'lat = $lat, lng = $long',
        ),
      )
    ].toSet();
  }

  Container buildMap() {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
    );

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.8, //set width 80% of display
      height: MediaQuery.of(context).size.width * 0.8, // set width for square
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mySet(),
      ),
      //color: Colors.grey,
    );
  }

  Container buildPosition() => Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: 250,
        child: DropdownButton<String>(
          items: positions
              .map(
                //map like JSON syntag
                (e) => DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_ind,
                        color: Colors.lightBlue,
                      ),
                      Text(e),
                    ],
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: choosePositon,
          hint: Text('Select Position'),
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          onChanged: (value) {
            setState(() {
              choosePositon = value;
            });
          },
        ),
      );

  Container buildName() {
    return Container(
      width: 250,
      height: 40,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(),
            hintText: 'Display Name',
            prefixIcon: Icon(
              Icons.face,
              color: Color(0xFF53B1F9),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.lightBlue),
            ),
          ),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      width: 250,
      height: 40,
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Display User',
          prefixIcon: Icon(
            Icons.account_circle,
            color: Color(0xFF53B1F9),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: 250,
      height: 40,
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Display Password',
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFF53B1F9),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        'Create New User',
      ),
    );
  }

  Future<Null> chooseAvatar(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Container buildAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseAvatar(ImageSource.camera),
          ),
          Container(
            width: 180,
            height: 180,
            child: file == null
                ? Image.asset('images/user.png')
                : Image.file(file),
          ),
          IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () => chooseAvatar(ImageSource.gallery)),
        ],
      ),
    );
  }
}
