import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final databaseReferencePulses = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('Rotations');

class SinglesGameStart extends StatefulWidget {
  final double totalDistance;
  final String numMiles;

  SinglesGameStart({Key key, @required this.totalDistance, this.numMiles}): super(key: key);
  @override
  _SinglesGameStartState createState() => _SinglesGameStartState(totalDistance: totalDistance, numMiles: numMiles);
}

class _SinglesGameStartState extends State<SinglesGameStart> {
  DateTime now = DateTime.now();
  double percentDistProgBar=0;
  double distance=0;
  double totalDistance=0;
  String numMiles;

  final double mile = 63360.0;
  
  _SinglesGameStartState({Key key, @required this.totalDistance, this.numMiles});
  
  Widget _back(){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
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
          child: Text("Singles",
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

  Widget _singlePlayerProgress(){
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              StreamBuilder(
                stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  return Text(userDocument["username"],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffcc00),
                    )
                  );
                }
              ),
            ],
          ),
        ),
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: _progressBar(),
          )
        ),
      ]
    );
  }

  Widget _progressBar(){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: StreamBuilder(
        stream: databaseReferencePulses.onValue,
        builder: (context, snap) {
          if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
            DataSnapshot snapshot = snap.data.snapshot;
            var value = snapshot.value;
            percentDistProgBar = value.toInt()*50*3.14159/totalDistance;
            distance = value.toInt()*50*3.14159/mile;
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Distance: ${distance.toStringAsFixed(2)} miles",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        )
                      ),
                      Text("Goal: $numMiles Mile",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        )
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: LinearProgressIndicator(
                    value: percentDistProgBar,
                    backgroundColor: Color(0xFFFF5A5A),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF71FF5A)),
                  ),
                ),
              ]
            );
          }
          else{
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Distance: 0.00 miles",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        )
                      ),
                      Text("Goal: 0.0 Mile",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        )
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: LinearProgressIndicator(
                    value: percentDistProgBar,
                    backgroundColor: Color(0xFFFF5A5A),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF71FF5A)),
                  ),
                ),
              ]
            );
          }
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              _back(),
              _title(),
              SizedBox(height:15),
              _singlePlayerProgress(),
            ],
          )
        ),
      ),
    );
  }
}
