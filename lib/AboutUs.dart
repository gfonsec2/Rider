import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider/newHome.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';


class AboutUs extends StatefulWidget {
  AboutUs({Key key}): super(key: key);
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
    DateTime now = DateTime.now();

  _AboutUsState({Key key});

  Widget _back(){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context,MaterialPageRoute(builder: (context) => Settings()));
      },
      child: Row(
        children: <Widget>[
          Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
          Text("Back"),
        ],
      )
    );        
  }

  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("About Us",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(DateFormat("EEEE, MMMM d").format(now),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
        ),
        SizedBox(height:10),
      ]
    );
  }
  
  Widget _aboutUs(){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Text("Rider",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffcc00),
                )
              ),
              SizedBox(height: 15),
              Text("Rider is a mobile phone exercise application specifically for assault spin bikes. The application works with a magnetic sensor to read the rotations from your out-of-touch-with-technology assault bike.",
              style: TextStyle(
                  fontSize: 20,
                )
              ),
            ],
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _back(),
            _title(),
            SizedBox(height: 5),
            _aboutUs(),
          ],
        )
      ),
    );
  }
}