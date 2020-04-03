import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Profile extends StatefulWidget {
  var user;
  Profile({Key key, this.user}): super(key: key);
  _ProfileState createState() => _ProfileState(user: user);
}

class _ProfileState extends State<Profile> {
  var user;
  DateTime now = DateTime.now();
  _ProfileState({Key key, @required this.user});
  
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
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Rider", style: TextStyle(fontSize: 35, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)  ),)
                        ],
                      ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
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
