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

  Widget _game0(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(totalDistance: 31680.0, numMiles: "0.5")));
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
                        colors: [Color(0xff916DD5), Color(0xffFFCC00)])),
                    child: Center(
                      child: Text(".5 mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
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
                      Text("Complete a half Mile as\nfast as you can!",
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


  Widget _game1(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(totalDistance: 63360.0, numMiles: "1")));
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
                        colors: [Color(0xffFFCC00), Color(0xffFF6666)])),
                    child: Center(
                      child: Text("1 mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
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
                      Text("Complete 1 Mile as fast\nas you can!",
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

  Widget _game2(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(totalDistance: 126720.0, numMiles: "2")));
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
                        colors: [Color(0xffFF6666), Color(0xff60CECE)])),
                    child: Center(
                      child: Text("2 mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
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
                      Text("Complete 2 Miles as fast\nas you can!",
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

  Widget _game3(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(totalDistance: 190080.0, numMiles: "3",)));
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
                        colors: [Color(0xff60CECE), Color(0xff916DD5)])),
                    child: Center(
                      child: Text("3 mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
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
                      Text("Complete 3 Miles as fast\nas you can!",
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
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _back(),
            _title(),
            _game0(),
            _game1(),
            _game2(),
            _game3(),
          ],
        )
      ),
    );
  }
}
