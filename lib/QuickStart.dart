import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';
import 'Records.dart';

class QuickStart extends StatefulWidget {
  @override
  _QuickStartState createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart> {
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
          child: Text("Quick Start",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Tuesday, February 25",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            )
          ),
        ),
        SizedBox(height: 10)
      ]
    );
  }
  
  Widget _mph(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      elevation: 20,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
            Container(
              height: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
            Container(
              height: 285.0,
              width: 285.0,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("23",
                  style: TextStyle(fontSize: 120)
                  ),
                  Text("MPH",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _dist(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      elevation: 20,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
            Container(
              height: 125.0,
              width: 125.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff916DD5), Color(0xff66CCCC)]),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
                      Container(
              child: Column(
                children: <Widget>[
                  //Mau, Insert int _calories
                  Text("1.56",
                  style: TextStyle(fontSize: 45)
                  ),
                  Text("Miles",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _cal(){
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        elevation: 20,
        child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
            Container(
              height: 125.0,
              width: 125.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff66CCCC), Color(0xffFF6666)]),
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(150.0)),
               ),
            ),
                      Container(
              child: Column(
                children: <Widget>[
                  Text("173",
                  style: TextStyle(fontSize: 45)
                  ),
                  Text("Calories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
        ],
    ),
      );
  }

  Widget _stopwatch(context){
    return Container(
      height: 225,
      width: 400,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("00:00.00",
            style: TextStyle( fontSize: 80),
            ),
            Text("Elapsed Time",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
            ),
            OutlineButton(
              highlightElevation: 20,
              borderSide: BorderSide(
                color: Colors.black
              ),
              child: Text("Start", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
              onPressed: () {Navigator.pop(context);}
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: EdgeInsets.fromLTRB(15, 40, 15, 0),
      child: Column(
        children: <Widget>[
          _back(),
          _title(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _mph(),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _dist(),
                  _cal(),
                ],
              ),
              _stopwatch(context)
            ],
          ),
        ],
      ),
      ),
    );
  }
}
