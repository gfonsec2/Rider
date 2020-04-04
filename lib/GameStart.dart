import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'GamePlay.dart';

class GameStart extends StatefulWidget {
  final String p1Username;
  final String p1uid;
  GameStart({Key key, this.p1uid, this.p1Username}): super(key: key);
  @override
  _GameStartState createState() => _GameStartState(p1Username: p1Username, p1uid: p1uid);
}

class _GameStartState extends State<GameStart> {
  
  final String p1Username;
  final String p1uid;
  _GameStartState({Key key, @required this.p1Username, this.p1uid});
  DateTime now = DateTime.now();
  
  showAlertDialog(BuildContext context) {
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
    return RaisedButton(
      onPressed: () {
        startGame(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 40.0),
          alignment: Alignment.center,
          child: Text(
            "Start",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
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

  void startGame(context) async{
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    var _user = Firestore.instance.collection('users').document(user.uid);
    DocumentSnapshot _userDoc = await _user.get();
    var player2Username = _userDoc["username"];
    Navigator.push(context,MaterialPageRoute(builder: (context) => GamePlay(p1Username: p1Username, p1uid:p1uid, p2Username: player2Username, p2uid: user.uid)));
  }

  void leaveLobby(String p1uid, String p1Username) async {
    var _db = Firestore.instance.collection('lobbys').document(p1uid);
    _db.setData({
      'Player1': p1Username,
      'Player1id': p1uid,
      'Player2': '',
      'Player2id': '',
      'joinable': true,
    });
  }
}
