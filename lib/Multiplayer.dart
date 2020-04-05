import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rider/MultiplayerAwaitOpponent.dart';
import 'package:rider/MultiplayerJoinLobby.dart';

class Multiplayer extends StatefulWidget {
  @override
  _MultiplayerState createState() => _MultiplayerState();
}

class _MultiplayerState extends State<Multiplayer> {
  final databaseReference = Firestore.instance;
  DateTime now = DateTime.now();

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
      ]
    );
  }

  Widget _user(){
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Color(0xffffcc00)),
          StreamBuilder(
            stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              return Text(userDocument["username"],
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffC4C4C4),
                )
              );
            }
          ),
        ],
      )
    );
  }

  Widget _createLobby(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
                Text("Online",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffcc00),
                  )
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              createLobby();
              Navigator.push(context,MaterialPageRoute(builder: (context) => MultiplayerAwaitOpponent()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(11, 11, 0, 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xffFFCC00), Color(0xffFF6666)])),
                          child: Center(
                            child: Icon(IconData(58298, fontFamily: 'MaterialIcons'), size: 75, color: Colors.white,),
                          ),
                        ),
                        SizedBox(width:10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Create",
                              style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 34,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ),
                            Text("Create a lobby, invite\nfriends and go head\nto head to gain points.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Color(0xff838383),
                              )
                            ),
                          ]
                        ),
                      ],
                    ),
                    Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _joinLobby(){
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => MultiplayerJoinLobby()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Container(
            margin: EdgeInsets.fromLTRB(11, 11, 0, 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff60CECE), Color(0xff916DD5)])),
                      child: Center(
                        child: Icon(IconData(59513, fontFamily: 'MaterialIcons'), size: 75, color: Colors.white,),
                      ),
                    ),
                    SizedBox(width:10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Join",
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Join and play agaisnt\nany random user to\ngain points.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                  ],
                ),
                Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stats(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Statistics",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffcc00),
                )
              ),
            ],
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
              margin: EdgeInsets.fromLTRB(11, 11, 0, 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total Wins",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Wins: 3",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff838383),
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
              margin: EdgeInsets.fromLTRB(11, 11, 0, 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total Points",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Points: 1254",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff838383),
                        )
                      ),
                      Text("Below Average",
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
              margin: EdgeInsets.fromLTRB(11, 11, 0, 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Total Distance",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Distance: 72.3 Miles",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff838383),
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
              _user(),
              _createLobby(),
              _joinLobby(),
              _stats(),
            ],
          )
        ),
      ),
    );
  }

  createLobby() async {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    var _db = Firestore.instance.collection('lobbys').document(user.uid);
    var _user = Firestore.instance.collection('users').document(user.uid);
    DocumentSnapshot _userDoc = await _user.get();
    var player1Username = _userDoc["username"];
    _db.setData({
      'Player1': player1Username,
      'Player1id': user.uid,
      'Player2': "",
      'Player2id': "",
      'joinable': true,
      'playing': false,
    });
  }
}
