import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TrialFailed extends StatefulWidget {
  final double distance;
  TrialFailed({Key key, this.distance}) : super(key: key);

  @override
  _TrialFailedState createState() => _TrialFailedState(distance: distance);
}

class _TrialFailedState extends State<TrialFailed> {
  final double distance;
  _TrialFailedState({Key key, @required this.distance});

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
          Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13, color: Colors.white),
          Text("Home", style: TextStyle(color: Colors.white)),
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
            child: Text("Failed",
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
          Icon(IconData(58949, fontFamily: 'MaterialIcons'), size: 120, color: Colors.white),
          _firstPlace(),
          Card(
            color: Color(0xff66CCCC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text("Oh no! You ran out of time! Don't give up, and try again!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )
              ),
            )
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff916DD5),
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