import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/GameStart.dart';

class MultiplayerAwaitOpponent extends StatefulWidget {
  MultiplayerAwaitOpponent({Key key}): super(key: key);
  @override
  _MultiplayerAwaitOpponentState createState() => _MultiplayerAwaitOpponentState();
}

class _MultiplayerAwaitOpponentState extends State<MultiplayerAwaitOpponent> {
  DateTime now = DateTime.now();

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
          child: Text("Leave",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed:  () {
            Navigator.pop(context);
            Navigator.pop(context);
            destroyLobby();
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
        child: Text("Quit this Lobby?",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:140,
        child: Column(
          children: <Widget>[
            Text("Quit lobby and navigate back to Multiplayer Home?",
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _logo(),
          Column(
            mainAxisSize: MainAxisSize.min,
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
              StreamBuilder(
                stream: Firestore.instance.collection('lobbys').document(user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("... Lobby");
                  }
                  var userDocument = snapshot.data;
                  if(snapshot.hasData && !userDocument["joinable"]) {
                    Future<void>.microtask(() => Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => 
                          GameStart(p1uid: user.uid,
                            p1Username: userDocument["Player1"],
                            p2uid: userDocument["Player2id"],
                            p2Username: userDocument["Player2"]
                          )
                        )
                      )
                    );
                  }
                  return Text("Waiting for player to join your lobby...",
                    style: TextStyle(fontSize: 20,
                      color: Color(0xff838383),
                      fontWeight: FontWeight.w200,
                    )
                  );
                }
              ),
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

  void destroyLobby(){
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    var _db = Firestore.instance.collection('lobbys').document(user.uid);
    _db.delete();
  }

  void joinGame(BuildContext context, String username, String id){
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameStart(p1Username: username, p1uid: id)));
  }
}
