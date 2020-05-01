import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:rider/GameResults.dart';
import 'package:rider/auth.dart';
import 'package:rider/timer_page.dart';

final databaseReference = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('RPM');
final databaseReferencePulses = FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').child('Rotations');
final databaseReference2 = FirebaseDatabase.instance.reference().child("user2").child('rotations_per_minute_stream').child('RPM');
final databaseReferencePulses2 = FirebaseDatabase.instance.reference().child("user2").child('rotations_per_minute_stream').child('Rotations');

class GamePlay extends StatefulWidget {
  final String p1Username;
  final String p1uid;
  final String p2Username;
  final String p2uid;
  GamePlay({Key key, this.p1uid, this.p1Username, this.p2uid, this.p2Username}): super(key: key);
  @override
  _GamePlayState createState() => _GamePlayState(p1Username: p1Username, p1uid: p1uid, p2Username: p2Username, p2uid: p2uid);
}

class _GamePlayState extends State<GamePlay> {
  
  final String p1Username;
  final String p1uid;
  final String p2Username;
  final String p2uid;
  _GamePlayState({Key key, @required this.p1Username, this.p1uid, this.p2Username, this.p2uid});
  DateTime now = DateTime.now();

  bool playing = true;
  bool read = true;
  
  int _start = 3;
  int _current = 3;
  bool _visible = true;

  double distance = 0;
  double percentDistProgBar=0.0;
  final double mile = 31680.0;
  final double mile2 = 63360.0;
  int current=0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
  }

  quitGameAlertDialog(BuildContext context, String winner) {
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
        StreamBuilder(
          stream: Firestore.instance.collection('lobbys').document(p1uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading...");
            }
            var userDocument = snapshot.data;
            if(snapshot.hasData && read) {
              return FlatButton(
                child: Text("Quit",
                  style: TextStyle(
                    color: Color(0xff66CCCC),
                    fontSize: 25,
                  )
                ),
                onPressed:  () {
                  read = false;
                  var _db = Firestore.instance.collection('lobbys').document(p1uid);
                  _db.updateData({
                    "playing": false
                  }).then((result){
                    //print("new USer true");
                  }).catchError((onError){
                    print("onError");
                  });
                  gameFinish(p1uid, p1Username, p2Username, winner);
                },
              );
            }
            return FlatButton(
              onPressed: (){},
              child: Text("Quit",
                style: TextStyle(
                  color: Color(0xff66CCCC),
                  fontSize: 25,
                )
              ),
            );
          }
        ),
      ]
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text("Quit This Game?",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:110,
        child: Column(
          children: <Widget>[
            Text("Opponent will win the match.",
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
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _giveUp(){
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return GestureDetector(
      onTap: (){
        if(user.uid == p1uid){
          quitGameAlertDialog(context, p2uid);
        }
        else{
          quitGameAlertDialog(context, p1uid);
        }
      },
      child: StreamBuilder(
        stream: Firestore.instance.collection('lobbys').document(p1uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading...");
          }
          var userDocument = snapshot.data;
          if(snapshot.hasData && userDocument["playing"] == false && read) {
            read = false;
            gameFinish(p1uid, p1Username, p2Username, user.uid);
          }
          return Row(
            children: <Widget>[
              Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
              Text("Quit"),
            ],
          );
        }
      ),
    );        
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      _visible = false;
      sub.cancel();
      startTimer2();
    });
  }
String secondsStr;
  Widget _player1Card(){
    double mph=0;
    double diameter =25;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Color(0xff838383)),
                    Text(p1Username,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w200,
                        color: Color(0xffC4C4C4),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StreamBuilder(
                          stream: databaseReferencePulses.onValue,
                          builder: (context, snap) {
                            if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                              DataSnapshot snapshot = snap.data.snapshot;
                              var value = snapshot.value;
                              percentDistProgBar = value.toInt()*25*3.14159/mile;
                              distance = value.toInt()*diameter*3.14159/mile2;
                              if(distance >= 0.5 && playing == true){
                                playing = false;
                                //Future<void>.microtask(() => gameFinish(p1uid, p1Username, p2Username, p1uid));
                                gameFinish(p1uid, p1Username, p2Username, p1uid);
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("CURRENT\nMILES",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                  Text(distance.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                ],
                              );
                            }
                            else{
                              return Column(
                                children: <Widget>[
                                  Text("CURRENT\nMILES",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                  Text('0.00',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                ],
                              );
                            }
                          }
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('users').document(p1uid).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("AVG",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                                Text("MPH",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                                Text(userDocument["avgMph"].toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                    Card(
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
                                  stream: databaseReference.onValue,
                                  builder: (context, snap) {
                                    if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                                      DataSnapshot snapshot = snap.data.snapshot;
                                      var value = snapshot.value;
                                      mph = double.parse(value.toString());
                                      mph = (mph * diameter * 3.14159 *60/63360);
                                      return Text(mph.toInt().toString(),
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
                                Text("MPH",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
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
                            percentDistProgBar = value.toInt()*25*3.14159/mile;
                            distance = value.toInt()*25*3.14159/mile;
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
                                value: percentDistProgBar,
                                backgroundColor: Color(0xFFFF5A5A),
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF71FF5A)),
                              ),
                            );
                          }
                        }
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
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
                            Text("0.5 mi", style: TextStyle(fontSize: 15, color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        )
      )
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
    secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void startTimer2() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (current > 3599) {
            timer.cancel();
            //trialFailed(distance);
          } else {
            time = formatHHMMSS(current);
            current = current + 1;
          }
        },
      ),
    );
  }

  Widget _stopwatch(context){
    return Container(
      height: 150,
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //TimerPage()
            //TimerPage2(),
            Text(time,
              style: TextStyle(
                fontSize: 85,
              ),
            ),
            Text("Elapsed Time",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _player2Card(){
    double mph=0;
    double diameter =25;
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Color(0xff838383)),
                    Text(p2Username,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w200,
                        color: Color(0xffC4C4C4),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StreamBuilder(
                          stream: databaseReferencePulses2.onValue,
                          builder: (context, snap) {
                            if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                              DataSnapshot snapshot = snap.data.snapshot;
                              var value = snapshot.value;
                              percentDistProgBar = value.toInt()*25*3.14159/mile;
                              distance = value.toInt()*diameter*3.14159/mile2;
                              if(distance >= 0.5 && playing == true){
                                playing = false;
                                //Future<void>.microtask(() => gameFinish(p1uid, p1Username, p2Username, p1uid));
                                gameFinish(p1uid, p1Username, p2Username, p2uid);
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("CURRENT\nMILES",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                  Text(distance.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                ],
                              );
                            }
                            else{
                              return Column(
                                children: <Widget>[
                                  Text("CURRENT\nMILES",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                  Text('0.00',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                    )
                                  ),
                                ],
                              );
                            }
                          }
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('users').document(p2uid).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("AVG",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                                Text("MPH",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                                Text(userDocument["avgMph"].toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )
                                ),
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                    Card(
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
                                colors: [Color(0xFF916DD5), Color(0xff66CCCC)]
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
                                  stream: databaseReference2.onValue,
                                  builder: (context, snap) {
                                    if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                                      DataSnapshot snapshot = snap.data.snapshot;
                                      var value = snapshot.value;
                                      mph = double.parse(value.toString());
                                      mph = (mph * diameter * 3.14159 *60/63360);
                                      return Text( mph.toInt().toString(),
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
                                Text("MPH",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
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
                        stream: databaseReferencePulses2.onValue,
                        builder: (context, snap) {
                          if(snap.hasData && !snap.hasError && snap.data.snapshot.value!=null){
                            DataSnapshot snapshot = snap.data.snapshot;
                            var value = snapshot.value;
                            percentDistProgBar = value.toInt()*25*3.14159/mile;
                            distance = value.toInt()*25*3.14159/mile;
                            return Container(
                              width: 200,
                              height: 20,
                              child: LinearProgressIndicator(
                                value: percentDistProgBar,
                                backgroundColor: Color(0xFFFF5A5A),
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF916DD5)),
                              ),
                            );
                          }
                          else{
                            return Container(
                              width: 200,
                              height: 20,
                              child: LinearProgressIndicator(
                                value: percentDistProgBar,
                                backgroundColor: Color(0xFFFF5A5A),
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF71FF5A)),
                              ),
                            );
                          }
                        }
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
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
                            Text("0.5 mi", style: TextStyle(fontSize: 15, color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        )
      )
    );
  }

  Widget _gameScreen(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
              Text("Quit"),
            ],
          ),
          _player1Card(),
          _stopwatch(context),
          _player2Card(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').update({
        'startReading': 1,
    });
    FirebaseDatabase.instance.reference().child("user2").child('rotations_per_minute_stream').update({
        'startReading': 1,
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: _gameScreen(),
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
                    child: _giveUp()
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Center(
              child: Opacity(
                opacity: _visible ? 1.0: 0.0,
                child: Text("$_current",
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

  gameFinish(String p1uid, String p1Username, String p2Username, String winner) async{
    resetRead();
    var _db;
    String loser;
    if(winner == p1uid){
      _db = Firestore.instance.collection('users').document(p1uid);
      loser = p2uid;
    }
    else{
      _db = Firestore.instance.collection('users').document(p2uid);
      loser = p1uid;
    }
    DocumentSnapshot _userDoc = await _db.get();
    var wins = _userDoc["totalWins"] + 1;
    _db.updateData({
      "totalWins": wins
    }).then((result){
      //print("new USer true");
    }).catchError((onError){
      print("onError");
    });
    print(current);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameResults(
      p1uid: p1uid,
      p1Username: p1Username,
      p2uid: p2uid,
      p2Username: p2Username,
      winner: winner,
      loser: loser,
      time: current
    )));
  }
}