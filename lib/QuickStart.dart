import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:rider/auth.dart';
import 'timer_page.dart';
import 'package:intl/intl.dart';

final databaseReference = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('RPM');
final databaseReferencePulses = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('Rotations');
final databaseRead = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('startReading');

class QuickStart extends StatefulWidget {
  final double mph;
  final double distance;
  final int calories;

  QuickStart({Key key, @required this.mph, this.distance,this.calories}): super(key: key);
  @override
  _QuickStartState createState() => _QuickStartState(mph: mph, distance: distance,calories: calories);
}

class _QuickStartState extends State<QuickStart> {
  double mph=0;
  double distance=0;
  int calories=0;
  DateTime now = DateTime.now();

  _QuickStartState({Key key, @required this.mph, this.distance, this.calories});
  
  void quit(FirebaseUser user, double timeDone, int caloriesDone, double milesDone)
  {
    //updateUserData(user, timeDone, caloriesDone, milesDone);
  }

  showAlertDialog(BuildContext context, FirebaseUser user) {
    // set up the buttons
    //FirebaseUser user = Provider.of<FirebaseUser>(context);
    Widget buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          child: Text("Cancel",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 25,
            )
          ),
          onPressed:  () => Navigator.pop(context)
        ),
        FlatButton(
          child: Text("OK",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed: () {
            quit(user, mph, calories, distance);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ]
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text("Navigate Home",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:140,
        child: Column(
          children: <Widget>[
            Text("You're about to exit Quick Start, press ok to go back.",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200
              )
            ),
            Container(
              child: buttons
            )
          ],
        ),
      )
      //Text("You're about to exit the Quick Start session. Would you like to save session?"),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _back(FirebaseUser user){
    return GestureDetector(
      onTap: (){
        showAlertDialog(context, user);
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
          child: Text("Quick Start",
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
              color: Colors.grey
            )
          ),
        ),
        SizedBox(height: 10)
      ]
    );
  }
  
  Widget _mph(){
    double diameter =50;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      elevation: 20,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            height: 285.0,
            width: 285.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, snap) {
                    if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                      DataSnapshot snapshot = snap.data.snapshot;
                      var value = snapshot.value;
                      mph = double.parse(value.toString());
                      mph = (mph * diameter * 3.14159 *60/63360);
                      return Text( mph.toInt().toString(),
                        style: TextStyle(fontSize: 80)
                      );
                    }
                    else{
                      return Text("0",
                        style: TextStyle(fontSize: 80)
                      );
                    }
                  }
                ),
                Text("MPH",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _dist(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      elevation: 20,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 125.0,
            width: 125.0,
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff916DD5), Color(0xff66CCCC)]),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            height: 110.0,
            width: 110.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: databaseReferencePulses.onValue,
                  builder: (context, snap) {
                    if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                      DataSnapshot snapshot = snap.data.snapshot;
                      var value = snapshot.value;
                      distance = value.toInt()*50*3.14159/63360;
                      return Text(
                        distance.toStringAsFixed(1),
                        style: TextStyle(fontSize: 45)
                      );
                    }
                    else{
                      return Text("0",
                      style: TextStyle(fontSize: 45));
                    }
                  }
                ),
                Text("Miles",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cal(){
    int calories;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      elevation: 20,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 125.0,
            width: 125.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff66CCCC), Color(0xffFF6666)]
              ),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            height: 110.0,
            width: 110.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: databaseReferencePulses.onValue,
                  builder: (context, snap) {
                    if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                      DataSnapshot snapshot = snap.data.snapshot;
                      var value = snapshot.value;
                      distance = value.toInt()*50*3.14159/63360;
                      calories = (distance*50).toInt();
                      return Text(calories.toString(),
                        style: TextStyle(fontSize: 45)
                      );
                    }
                    else{
                      return Text("0",
                        style: TextStyle(fontSize: 45)
                      );
                    }
                  }
                ),
                Text("Calories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _stopwatch(context){
    return Container(
      height: 225,
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TimerPage()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').update({
        'startReading': 1,
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              _back(user),
              _title(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _mph(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _dist(),
                      _cal(),
                    ],
                  ),
                  _stopwatch(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}