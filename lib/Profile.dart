import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/newHome.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';


class Profile extends StatefulWidget {
  Profile({Key key}): super(key: key);
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime now = DateTime.now();
  _ProfileState({Key key});
  
  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Profile",
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
  
  Widget _profile(){
    return Container(
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
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/OriRider.png"),
                    ),
                  ),
                  SizedBox(width:20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Users Name",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("_userName",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _stats(){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text("Statistics",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ProximaNova',
              fontSize: 22,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            )
          ),
        ),
      ),
    );
  }

  Widget _grid(){
    return Center(
      child:Container(
        width: double.infinity,
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing:4.0,
          mainAxisSpacing:4.0,
            children: <Widget>[
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Multiplayer',
                        style: TextStyle(
                          fontSize: 22.0,
                        )
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("586")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Cal"),
                                Text("12,944")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("High Speed"),
                                Text("29 mph")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("103")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Top 1st"),
                                Text("13")
                              ],
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                )
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Singles',
                        style: TextStyle(
                          fontSize: 22.0,
                        )
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("103")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("High Score"),
                                Text("216")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Cal"),
                                Text("4863")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("High Speed"),
                                Text("26 mph")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Time Spent"),
                                Text("25 hrs")
                              ],
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                )
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('QuickStart',
                        style: TextStyle(
                          fontSize: 22.0,
                        )
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("586")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Cal"),
                                Text("12,944")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("High Speed"),
                                Text("29 mph")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("103")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Top 1st"),
                                Text("13")
                              ],
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                )
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Trials',
                        style: TextStyle(
                          fontSize: 22.0,
                        )
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("586")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Cal"),
                                Text("12,944")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("High Speed"),
                                Text("29 mph")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Mi"),
                                Text("103")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Top 1st"),
                                Text("13")
                              ],
                            ),
                          ],
                        )
                      ),
                    ]
                  )
                )
              ),
            ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _title(),
            SizedBox(height:15),
            _profile(),
            _stats(),
            _grid(),
          ],
        )
      ),
    );
  }
}
