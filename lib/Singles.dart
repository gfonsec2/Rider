import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider/SinglesGameStart.dart';

class Singles extends StatefulWidget {
  Singles({Key key}): super(key: key);
  @override
  _SinglesState createState() => _SinglesState();
}

class _SinglesState extends State<Singles> {
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
          child: Text("Singles",
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

  Widget _game(double totalDistance, String miles, String prompt, Color upper, Color lower){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(totalDistance: totalDistance, numMiles: miles)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.fromLTRB(17, 25, 0, 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [upper, lower])),
                    child: Center(
                      child: Text("$miles mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                  SizedBox(width:20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Game",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Complete a $prompt as\nfast as you can!",
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
              _game(31680.0, "0.5", "Half Mile", Color(0xff916DD5), Color(0xffFFCC00)),
              _game(63360.0, "1", "1 Mile", Color(0xffFFCC00), Color(0xffFF6666)),
              _game(126720.0, "2", "2 Miles", Color(0xffFF6666), Color(0xff60CECE)),
              _game(190080.0, "3", "3 Miles", Color(0xff60CECE), Color(0xff916DD5)),
            ],
          )
        ),
      ),
    );
  }
}
