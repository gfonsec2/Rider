import 'package:flutter/material.dart';
import 'Records.dart';
import 'Settings.dart';
import 'QuickStart.dart';
import 'Trials.dart';
import 'Multiplayer.dart';
import 'Singles.dart';

class Home extends StatefulWidget {
  final int selectedIndex;
  Home({Key key, @required this.selectedIndex}): super(key: key);
  @override
  _HomeState createState() => _HomeState(selectedIndex: selectedIndex);
}

class _HomeState extends State<Home> {
  final int selectedIndex;
  _HomeState({Key key, @required this.selectedIndex});
  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Home",
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
                  color: Colors.grey)),
        ),
        SizedBox(height:10),
      ]
    );
  }

  Widget _prevWorkout(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Previous Workout",
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
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("12.9",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        )
                      ),
                      SizedBox(width:10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("AVG",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                          Text("SPEED",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("1.56",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        )
                      ),
                      SizedBox(width:10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TOTAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                          Text("MILES",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("173",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        )
                      ),
                      SizedBox(width:10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TOTAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                          Text("CAL",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                ),
              ]
            )
          )
        ),
      ]
    );
  }

  Widget _menuHeader(){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
          Text("Menu",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xffffcc00),
            )
          ),
        ],
      ),
    );
  }

  Widget _menu(){
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 25),
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => QuickStart()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
                child: Row(
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
                        child: Text("Q",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                    SizedBox(width:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Quick Start",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Jump straight into the\nspeedometer and stopwatch\nmenu.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    SizedBox(width:20),
                    Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => Trials()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
                child: Row(
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
                        child: Text("T",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                    SizedBox(width:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Trials",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Race against the clock and\ncover a set distance with an\neasy, medium, and hard modes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    SizedBox(width:20),
                    Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => Multiplayer()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
                child: Row(
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
                        child: Text("M",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                    SizedBox(width:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Multiplayer",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Connect with friends and\nplay games designed to test\nyour abilities.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    SizedBox(width:20),
                    Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => Singles()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
                child: Row(
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
                        child: Text("S",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                    SizedBox(width:20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Singles",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          )
                        ),
                        Text("Solo player minigames. Play a\nvariety of assault bike games to\nbeat your personal high score.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff838383),
                          )
                        ),
                      ]
                    ),
                    SizedBox(width:20),
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

  void _onItemTapped(int index) {
    setState(() {
      if(index == 1){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Records(selectedIndex: 1)));
      }
      if(index == 2){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Settings(selectedIndex: 2)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: selectedIndex, // this will be set when a new tab is tapped
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Records'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings')
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _title(),
            _prevWorkout(),
            _menuHeader(),
            _menu()
          ],
        )
      ),
    );
  }
}
