import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MultiplayerJoinLobby extends StatefulWidget {
  @override
  _MultiplayerJoinLobbyState createState() => _MultiplayerJoinLobbyState();
}

class _MultiplayerJoinLobbyState extends State<MultiplayerJoinLobby> {
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

  Widget _availableLobbys(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Available Lobby's to Join",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffcc00),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lobby(String username, int points){
    return Container(
      child: GestureDetector(
        onTap: (){
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Color(0xffffcc00)),
                    SizedBox(width:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(username,
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Points: $points",
                          style: TextStyle(
                            fontSize: 14,
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
              _availableLobbys(),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 25),
                  children: <Widget>[
                    _lobby("Maufg98", 1247),
                    _lobby("ElCuuuuh", 321),
                    _lobby("ConejitoMalo", 10324),
                    _lobby("Pikacuh", 586),
                    _lobby("elDude", 98),
                    _lobby("ericMars", 7512),
                    _lobby("gfonsec2", 99999),
                  ]
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
