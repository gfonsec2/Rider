import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rider/newHome.dart';

import 'Home.dart';
import 'auth.dart';

  FirebaseUser user;


class GameResults extends StatefulWidget {
  final String p1uid;
  final String p1Username;
  final String p2uid;
  final String p2Username;
  final String winner;
  final String loser;
  GameResults({Key key, this.p1uid, this.p2uid, this.p1Username, this.winner, this.loser, this.p2Username, String time}) : super(key: key);

  @override
  _GameResultsState createState() => _GameResultsState(p1uid: p1uid, p1Username: p1Username, p2uid: p2uid, p2Username: p2Username, winner: winner, loser: loser);
}

class _GameResultsState extends State<GameResults> {
  final String p1uid;
  final String p1Username;
  final String p2uid;
  final String p2Username;
  final String winner;
  final String loser;
  final String time;
  _GameResultsState({Key key, @required this.p1uid, this.winner, this.p2uid, this.p1Username, this.p2Username, this.loser, this.time});

  Future<void> saveData()
  async {
    AuthService authService;
   // FirebaseUser user;

    double miles;
    int calories;
    double minutes = int.parse(time)/60;
    var va = await databaseReferencePulses.once().then((value) => 
    miles = (value.value.toInt()*50*3.14159/63360).toDouble());
    resetRead();


      calories = await  (miles*50).toInt();
      updatePrevWorkout(user, minutes, calories, miles);
      
      Navigator.pop(context);
      Navigator.pop(context);

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
            quit(context);
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
            Text("Leave to Home Menu?",
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
            child: Text("Place",
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
    var first;
    if (winner == p1uid){
      first = p1Username;
    }
    else{
      first = p2Username;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text("1st", style: TextStyle(fontSize: 95,fontFamily: "Marker Felt" , color: Colors.white))),
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
                    children: <Widget>[
                      Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Colors.white),
                      Text(first,
                        style: TextStyle(
                          fontSize: 34,
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
                          Text("MILES",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text("1.00",
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
                          Text("COMPLETED",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                          Text("MILES",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text("1.00",
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
                      Text("12.8",
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

  Widget _secondPlace(){
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
            child: Text("Place",
              style: TextStyle(
                fontSize: 20,
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

  Widget _secondPlaceCard(){
    var second;
    if (loser == p1uid){
      second = p1Username;
    }
    else{
      second = p2Username;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Column(
        children: <Widget>[
          Text("2nd", style: TextStyle(fontSize: 75,fontFamily: "Marker Felt" , color: Colors.white)),
          _secondPlace(),
          Card(
            color: Color(0xff916DD5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Colors.white),
                      Text(second,
                        style: TextStyle(
                          fontSize: 34,
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
                          Text("MILES",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text("1.00",
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
                          Text("COMPLETED",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                          Text("MILES",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            )
                          ),
                        ]
                      ),
                      Text("0.86",
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
                      Text("11.4",
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Icon(MdiIcons.crown),
              _back(),
              _firstPlaceCard(),
              _secondPlaceCard()
            ],
          ),
        ),
      ),
    );
  }

  quit(context){
    var _db = Firestore.instance.collection('lobbys').document(p1uid);
    _db.delete();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyTabbedPage()), (route) => false);
  }
}