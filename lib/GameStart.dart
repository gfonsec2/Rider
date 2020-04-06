import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'GamePlay.dart';

class GameStart extends StatefulWidget {
  final String p1Username;
  final String p1uid;
  final String p2uid;
  final String p2Username;
  GameStart({Key key, this.p1uid, this.p1Username,this.p2Username,this.p2uid}): super(key: key);
  @override
  _GameStartState createState() => _GameStartState(p1Username: p1Username, p1uid: p1uid, p2Username: p2Username, p2uid: p2uid);
}

class _GameStartState extends State<GameStart> {
  @override
  void initState() {
    super.initState();
    startGame();
    Timer(Duration(seconds: 10), () {
       Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => 
            GamePlay(
              p1uid: p1uid,
              p1Username: p1Username,
              p2uid: p2uid,
              p2Username: p2Username
            )
          )
        );
      }
    );
  }
  
  final String p1Username;
  final String p1uid;
  final String p2Username;
  final String p2uid;
  _GameStartState({Key key, @required this.p1Username, this.p1uid, this.p2uid, this.p2Username});
  DateTime now = DateTime.now();

  alertDialogPlayer1Leaving(BuildContext context) {
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
          child: Text("Quit",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed:  () {
            leaveLobby(p1uid, p1Username);
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
        child: Text("Quit This Game?",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:140,
        child: Column(
          children: <Widget>[
            Text("Leave Lobby and navigate back to search for new player?",
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

  alertDialogPlayer2Leaving(BuildContext context) {
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
          child: Text("Leave",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed:  () {
            leaveLobby(p1uid, p1Username);
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
        child: Text("Leave this Lobby?",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:140,
        child: Column(
          children: <Widget>[
            Text("Leave lobby and navigate back to Join Lobby Screen?",
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
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('lobbys').document(p1uid).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return GestureDetector(
            onTap: (){
            },
            child: Row(
              children: <Widget>[
                Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
                Text("Back"),
              ],
            )
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          var userDocument = snapshot.data;
          if(user.uid == userDocument["Player1id"]){
            return GestureDetector(
              onTap: (){
                alertDialogPlayer1Leaving(context);
              },
              child: Row(
                children: <Widget>[
                  Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
                  Text("Back"),
                ],
              )
            );
          }
          else{
            return GestureDetector(
              onTap: (){
                alertDialogPlayer2Leaving(context);
              },
              child: Row(
                children: <Widget>[
                  Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
                  Text("Back"),
                ],
              )
            );
          }
        }
        else{
          return GestureDetector(
            onTap: (){},
            child: Row(
              children: <Widget>[
                Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
                Text("Back"),
              ],
            )
          );
        }
      }
    );
  }

  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Multiplayer",
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

  Widget _playerVS(){
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('lobbys').document(p1uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading...");
              }
              var userDocument = snapshot.data;
              if(snapshot.hasData && userDocument["joinable"]) {
                Future<void>.microtask(() => Navigator.pop(context));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(userDocument["Player1"],
                        style: TextStyle(
                          color: Color(0xffC4C4C4),
                          fontSize: 24,
                        ),
                      ),
                      Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 100, color: Color(0xff838383)),
                    ],
                  ),
                  Text("VS",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(userDocument["Player2"],
                        style: TextStyle(
                          color: Color(0xffC4C4C4),
                          fontSize: 24,
                        ),
                      ),
                      Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 100, color: Color(0xff838383)),
                    ],
                  ),
                ]
              );
            }
          ),
          SizedBox(height: 50),
          _startButton(),
        ],
      ),
    );
  }
  
  Widget _startButton(){
    return Center(
      child: Column(children: <Widget>[
        Text("Creating Game... Get Ready!!!",
          style: TextStyle(fontSize: 20,
            color: Color(0xff838383),
            fontWeight: FontWeight.w200,
          )
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(
          backgroundColor: Color(0xffFFCC00),
        ),
      ],)
    );
  }

  Widget _playerStats(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Wins",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Total Wins",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Wins: 8",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                        Text("Wins: 46",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Below Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Points",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Total Points",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Points: 1254",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                        Text("Points: 6923",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Below Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Above Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Distance",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Total Distance",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Distance: 72.3 Miles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                        Text("Distance: 182.3 Miles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Above Average",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _back(),
                  _title(),
                ],
              ),
              _playerVS(),
              _playerStats(),
            ],
          )
        ),
      ),
    );
  }

  startGame(){
    var _db = Firestore.instance.collection('lobbys').document(p1uid);
    _db.setData({
      'Player1': p1Username,
      'Player1id': p1uid,
      'Player2': p2Username,
      'Player2id': p2uid,
      'joinable': false,
      'playing': true,
    });
  }

  void leaveLobby(String p1uid, String p1Username) async {
    var _db = Firestore.instance.collection('lobbys').document(p1uid);
    _db.setData({
      'Player1': p1Username,
      'Player1id': p1uid,
      'Player2': '',
      'Player2id': '',
      'joinable': true,
      'playing': false,
    });
  }
}
