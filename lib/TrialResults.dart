import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TrialResults extends StatefulWidget {
  final String goalTime;
  final String completedTime;
  final double distance;
  final int calories;
  final String yourRecordTime;
  final int avgMph;
  TrialResults({Key key, this.distance, this.calories, this.completedTime, this.yourRecordTime, this.goalTime, this.avgMph}) : super(key: key);

  @override
  _TrialResultsState createState() => _TrialResultsState(goalTime: goalTime, completedTime: completedTime, distance: distance, calories: calories, yourRecordTime: yourRecordTime, avgMph: avgMph);
}

class _TrialResultsState extends State<TrialResults> {
  final String goalTime;
  final String completedTime;
  final double distance;
  final int calories;
  final String yourRecordTime;
  final int avgMph;
  _TrialResultsState({Key key, @required this.distance, this.calories, this.completedTime, this.yourRecordTime, this.goalTime, this.avgMph});

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
            Text("Leave to Trials Menu?",
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
                      Text("Complete Under",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )
                      ),
                      Text(goalTime,
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
                      Text(yourRecordTime,
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
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Time Remaining",
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