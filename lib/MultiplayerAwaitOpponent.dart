import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiplayerAwaitOpponent extends StatefulWidget {
  MultiplayerAwaitOpponent({Key key}): super(key: key);
  @override
  _MultiplayerAwaitOpponentState createState() => _MultiplayerAwaitOpponentState();
}

class _MultiplayerAwaitOpponentState extends State<MultiplayerAwaitOpponent> {
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

  Widget _logo(){
    return Container(
      height: 150.0,
      width: 150.0,
      decoration: BoxDecoration(
        color: Color(0xffFFCC00),
        borderRadius: BorderRadius.all( Radius.circular(150.0)),
      ),
      child: Center(
        child: Text("R",
          style: TextStyle(fontSize: 95,
            fontFamily: "Marker Felt",
            color: Colors.white
          )
        )
      ),
    );
  }

  Widget _waitForOpponentPrompt(){
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _logo(),
          Column(
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("... Lobby");
                  }
                  var userDocument = snapshot.data;
                  return Text("${userDocument["username"]}'s Lobby",
                    style: TextStyle(fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    )
                  );
                }
              ),
              Text("Waiting for player to join your lobby...",
                style: TextStyle(fontSize: 20,
                  color: Color(0xff838383),
                  fontWeight: FontWeight.w200,
                )
              )
            ],
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
            children: <Widget>[
              _back(),
              SizedBox(height: 100),
              _waitForOpponentPrompt(),
            ],
          )
        ),
      ),
    );
  }
}
