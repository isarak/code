import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> positions = [ // List<type> is array
    'Computer technicial',
    'Manager',
    'Administrator',
    'Accounting',
    'Finacial',
    'Officer',
  ];

  String choosePositon; //defualt is null
  double lat, long; //defualt is null

  @override
  void initState() {
    // initState is first run.
    // in debug mode press R to run initState
    super.initState();
    findLatlng();
  }

  Future<Null> findLatlng()async{
    LocationData locationData = await findLocation(); 
    lat = locationData.latitude;
    long = locationData.longitude;
    print('lat = $lat,lng=$long');
  }

  Future<LocationData> findLocation()async{
    Location location = Location(); //Location is class of package location
    try {
      return await location.getLocation(); //await is watting for complete command. 
    } catch (e) {
      print('Can not load location. error code ==>${e.toString()}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // appBar is show bar on apps.
      body: SingleChildScrollView( //SingleChildScrollView is Scroll View
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
            buildMap(),
          ],
        ),
      ),
    );
  }

  Container buildMap() => Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width:
            MediaQuery.of(context).size.width * 0.8, //set width 80% of display
        height: MediaQuery.of(context).size.width * 0.8, // set width for square
        color: Colors.grey,
      );

  Container buildPosition() => Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: 250,
        child: DropdownButton<String>( 
          items: positions
              .map(
                //map like JSON syntag
                (e) => DropdownMenuItem(
                  child: Text(e),
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

  Container buildAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
          Container(
            width: 180,
            height: 180,
            child: Image.asset('images/user.png'),
          ),
          IconButton(icon: Icon(Icons.add_photo_alternate), onPressed: null),
        ],
      ),
    );
  }
}
