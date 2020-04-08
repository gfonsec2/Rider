import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rider/GameStart.dart';

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
          Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Colors.grey),
          StreamBuilder(
            stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              return Text(userDocument["username"],
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
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
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Active Sessions",
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

  Widget _lobby(String p1Username, String p1uid){
    return GestureDetector(
      onTap: (){
        joinGame(p1uid, p1Username, context);
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
                  Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 50, color: Colors.grey),
                  SizedBox(width:20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(p1Username,
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Points: 0",
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
    );
  }

  Widget _streamBuilderLobbys(){
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: Firestore.instance.collection('lobbys').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Connecting...');
            final int cardLength = snapshot.data.documents.length;
            return ListView.builder(
              padding: EdgeInsets.only(bottom:25),
              shrinkWrap: true,
              itemCount: cardLength,
              itemBuilder: (context, index) {
                final DocumentSnapshot _card= snapshot.data.documents[index];
                if(_card["joinable"])
                  return _lobby(_card["Player1"], _card["Player1id"]);
              },
            );
          }
        )
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
              _streamBuilderLobbys(),
            ],
          )
        ),
      ),
    );
  }

  joinGame(String p1uid, String p1Username, BuildContext context) async {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    var _db = Firestore.instance.collection('lobbys').document(p1uid);
    var _user = Firestore.instance.collection('users').document(user.uid);
    DocumentSnapshot _userDoc = await _user.get();
    var player2Username = _userDoc["username"];
    _db.setData({
      'Player1': p1Username,
      'Player1id': p1uid,
      'Player2': player2Username,
      'Player2id': user.uid,
      'joinable': false,
      'playing': false,
    });
    Navigator.push(context,MaterialPageRoute(builder: (context) => GameStart(p1Username: p1Username, p1uid:p1uid, p2Username: player2Username,p2uid: user.uid)));
  }
}
