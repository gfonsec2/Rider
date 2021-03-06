import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rider/TrialResults.dart';

import 'TrialFailed.dart';

final databaseReference = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('RPM');
final databaseReferencePulses = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('Rotations');

class TrialStart extends StatefulWidget {
  final String title;
  final double goal;
  final int start;
  final int current;
  TrialStart({Key key, @required this.title, this.start, this.goal, this.current}): super(key: key);
  @override
  _TrialStartState createState() => _TrialStartState(title: title, start: start, goal: goal, current: current);
}

class _TrialStartState extends State<TrialStart> {
  String title;
  double goal;
  int start = 0;
  int current = 0;

  bool _visible = true;

  double mph =0;
  double distance=0;
  int calories=0;
  DateTime now = DateTime.now();
  bool reading = true;
  _TrialStartState({Key key, @required this.title, this.distance, this.calories, this.goal, this.start, this.current});

  showAlertDialog(BuildContext context) {
    // set up the buttons
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
          onPressed:  () {Navigator.pop(context);Navigator.pop(context);},
        )
      ]
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text("Back to Trial Select",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:110,
        child: Column(
          children: <Widget>[
            Text("Would you like to stop your session?",
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

  Widget _back(){
    return GestureDetector(
      onTap: (){
        showAlertDialog(context);
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
          child: Text("Trials",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
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
    double diameter =25;
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
                      distance = value.toInt()*25*3.14159/63360;
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
                      distance = value.toInt()*25*3.14159/63360;
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

  Timer _timer;
  String time = "00:00";

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (current < 0) {
            timer.cancel();
            trialFailed(distance);
          } else {
            time = formatHHMMSS(current);
            current = current - 1;
          }
        },
      ),
    );
  }

  Timer _timer2;
  int _start = 3;

  void threeTwoOneTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer2 = new Timer.periodic(
      oneSecond,
      (Timer timer2) => setState(
        () {
          if (_start < 2) {
            _visible = false;
            //startTimer();
            timer2.cancel();
          } else {
            _start = _start - 1;
            if(_start == 1){
              startTimer();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    threeTwoOneTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   user = Provider.of<FirebaseUser>(context);

    FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').update({
        'startReading': 1,
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: <Widget>[
                  _back(),
                  _title(),
                  Column(
                    children: <Widget>[
                      _mph(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _dist(),
                          _cal(),
                        ],
                      ),
                      Text(time,
                        style: TextStyle(
                          fontSize: 85,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("0 mi", style: TextStyle(fontSize: 15, color: Colors.black))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: StreamBuilder(
                                stream: databaseReferencePulses.onValue,
                                builder: (context, snap) {
                                  if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                                    DataSnapshot snapshot = snap.data.snapshot;
                                    var value = snapshot.value;
                                    var percentDistProgBar = value.toInt()*25*3.14159/(goal * 63360.0);
                                    distance = value.toInt()*25*3.14159/(goal * 63360.0);
                                    if(percentDistProgBar >= 1.0 && reading){
                                      reading = false;
                                      //gameFinish();
                                      Future<void>.microtask(() => gameFinish(formatHHMMSS(start), formatHHMMSS(current), distance, (distance*50).toInt(), start - current));
                                      //gameFinish(formatHHMMSS(start), time, distance, (distance * 50).toInt(), current);
                                    }
                                    return Container(
                                      width: 200,
                                      height: 20,
                                      child: LinearProgressIndicator(
                                        value: percentDistProgBar,
                                        backgroundColor: Color(0xFFFF5A5A),
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66CCCC)),
                                      ),
                                    );
                                  }
                                  else{
                                    return Container(
                                      width: 200,
                                      height: 20,
                                      child: LinearProgressIndicator(
                                        value: 0.0,
                                        backgroundColor: Color(0xFFFF5A5A),
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF71FF5A)),
                                      ),
                                    );
                                  }
                                }
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("$goal mi", style: TextStyle(fontSize: 15, color: Colors.black))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
            
                    ],
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _visible ? .75 : 0.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.black,
                ),
                SafeArea(child: 
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: _back(),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Center(
              child: Opacity(
                opacity: _visible ? 1.0: 0.0,
                child: Text("$_start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 400,
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  trialFailed(distance){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrialFailed(distance: distance)));
  }

  gameFinish(String goalTime, String completedTime, double distance, int calories, int yourRecordTime){
    String record = formatHHMMSS(yourRecordTime);
    var avgMph = distance * 12 * 60;
    print(avgMph);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrialResults(
      goalTime: goalTime,
      completedTime: completedTime,
      distance: distance,
      calories: calories,
      yourRecordTime: record,
      time: current,
      avgMph: avgMph.toInt(),
    )));
  }
}
