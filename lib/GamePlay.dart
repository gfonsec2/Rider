import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';


class GamePlay extends StatefulWidget {
  final String p1Username;
  final String p1uid;
  final String p2Username;
  final String p2uid;
  GamePlay({Key key, this.p1uid, this.p1Username, this.p2uid, this.p2Username}): super(key: key);
  @override
  _GamePlayState createState() => _GamePlayState(p1Username: p1Username, p1uid: p1uid, p2Username: p2Username, p2uid: p2uid);
}

class _GamePlayState extends State<GamePlay> {
  
  final String p1Username;
  final String p1uid;
  final String p2Username;
  final String p2uid;
  _GamePlayState({Key key, @required this.p1Username, this.p1uid, this.p2Username, this.p2uid});
  DateTime now = DateTime.now();
  
  int _start = 3;
  int _current = 3;
  bool _visible = true;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
  }

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

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      _visible = false;
      sub.cancel();
    });
  }

  Widget _player1Card(){
    return Container();
  }

  Widget _timer(){
    return Container();
  }

  Widget _player2Card(){
    return Container();
  }

  Widget _gameScreen(){
    return Container(
      child: Column(
        children: <Widget>[
          _back(),
          _player1Card(),
          _timer(),
          _player2Card(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: _visible ? .75 : 0.0,
            child: Container(
              color: Colors.black,
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Stack(
                children: <Widget>[
                  _gameScreen(),
                  Container(
                    child: Center(
                      child: Opacity(
                        opacity: _visible ? 1.0: 0.0,
                        child: Text("$_current",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 400,
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}