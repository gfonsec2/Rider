import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rider/auth.dart';

import 'Home.dart';
import 'newHome.dart';
  FirebaseUser user;

class SinglesResults extends StatefulWidget {
  final String completedTime;
  final double distance;
  final int calories;
  final int avgMph;
  final int time;
  SinglesResults({Key key, this.distance, this.calories, this.completedTime,this.avgMph, this.time}) : super(key: key);

  @override
  _SinglesResultsState createState() => _SinglesResultsState(completedTime: completedTime, distance: distance, calories: calories, avgMph: avgMph, time: time);
}

class _SinglesResultsState extends State<SinglesResults> {
  final String completedTime;
  final double distance;
  final int calories;
  final int avgMph;
  final int time;
  _SinglesResultsState({Key key, @required this.distance, this.calories, this.completedTime, this.avgMph, this.time});

Future<void> saveData()
  async {
    AuthService authService;
   // FirebaseUser user;

    double minutes = time/60;
    
      updatePrevWorkout(user, minutes, calories, distance);
      resetRead();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyTabbedPage()), (route) => false);


    }

  alertDialog(BuildContext context) {
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
          child: Text("Exit",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed:  () {
            saveData();
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
        child: Text("Exit?",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Text("Leave to Singles Menu?",
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

  Widget _back(){
    return GestureDetector(
      onTap: (){
        alertDialog(context);
      },
      child: Row(
        children: <Widget>[
          Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
          Text("Home"),
        ],
      )
    );        
  }

  Widget _firstPlace(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Divider(
              thickness: 3,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text("Results",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: "Marker Felt"
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 3,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _firstPlaceCard(){
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: <Widget>[
          Icon(IconData(59450, fontFamily: 'MaterialIcons'), size: 120, color: Colors.white),
          _firstPlace(),
          Card(
            color: Color(0xffFF6666),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Completed Time",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )
                      ),
                      Text(completedTime,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TOTAL",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                          Text("DISTANCE (Mi)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text(distance.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("CALORIES",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                          Text("BURNED",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text(calories.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("AVERAGE",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                          Text("MPH",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text(avgMph.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                ),
              ]
            )
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
   user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      backgroundColor: Color(0xffffcc00),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              //Icon(MdiIcons.crown),
              _back(),
              SizedBox(height: 50),
              _firstPlaceCard(),
            ],
          ),
        ),
      ),
    );
  }
}