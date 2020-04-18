import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  Profile({Key key}): super(key: key);
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<int> time = <int>[1,1,1,1];
  final List<String> name = <String>["Multiplayer","Singles","QuickStart","Trials"];
  final List<double> distance = <double>[0.25,0.5,0.75,0.75];
  final List<int> speed = <int>[12,12,12,12];
  // final List<int> colorCodes = <int>[600, 500, 100];
  final List<String> difficulty = <String>["Beginner","Beginner","Beginner","Beginner"];
  final List<Color> color = <Color>[Color(0xff916DD5),Color(0xffFF6666),Color(0xff85B684),Color(0xff66CCCC),Color(0xff39EF36),Color(0xffFFCC00),Color(0xffFF6666),Color(0xffFF6666),Color(0xffFF6666)];
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
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Container(
      // color: Color(0xffffcc00),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Icon(IconData(59475, fontFamily: 'MaterialIcons'), size: 120, color: Colors.grey)
                        ],
                      ),
                    ),
                  SizedBox(width:5),
                  StreamBuilder(
                    stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(userDocument["name"],
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontSize: 33,
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            )
                          ),
                          Text(userDocument["username"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Color(0xff838383),
                            )
                          ),
                        ]
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Widget _stats(){
    return         Container(
          child: Row(
            children: <Widget>[
              Icon(IconData(59406, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Statistics",
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

 
    // Widget _Quickstart(){
    // return Card(
    //           shape: RoundedRectangleBorder(
    //             side: BorderSide(color: Colors.white70, width: 1),
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           elevation: 10,
    //           child: Container(
    //             height: 75,
    //             margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[

    //                     Text("QuickStart",
    //                       style: TextStyle(
    //                         color: Colors.purple,
    //                         fontSize: 22,
    //                         fontWeight: FontWeight.w300,
    //                       )
    //                     ),
    //                     Text("Distance: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Text("Speed: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Row(
    //                       children: <Widget>[
    //                         Text(" isai",
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w300,
    //                             color: Colors.white,
    //                           )
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
    //               ],
    //             ),
    //           ),
    //           );
    //     }

    //         Widget _Trials(){
    // return Card(
    //           shape: RoundedRectangleBorder(
    //             side: BorderSide(color: Colors.white70, width: 1),
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           elevation: 10,
    //           child: Container(
    //             height: 75,
    //             margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text("Trials",
    //                       style: TextStyle(
    //                         color: Colors.lightBlue,
    //                         fontSize: 22,
    //                         fontWeight: FontWeight.w300,
    //                       )
    //                     ),
    //                     Text("Distance: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Text("Speed: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Row(
    //                       children: <Widget>[
    //                         Text(" isai",
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w300,
    //                             color: Colors.white,
    //                           )
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
    //               ],
    //             ),
    //           ),
    //           );
    //     }

    //         Widget _Multiplayer(){
    // return Card(
    //           shape: RoundedRectangleBorder(
    //             side: BorderSide(color: Colors.white70, width: 1),
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           elevation: 10,
    //           child: Container(
    //             height: 75,
    //             margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text("Multiplayer",
    //                       style: TextStyle(
    //                         color: Colors.redAccent,
    //                         fontSize: 22,
    //                         fontWeight: FontWeight.w300,
    //                       )
    //                     ),
    //                     Text("Distance: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Text("Speed: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Row(
    //                       children: <Widget>[
    //                         Text(" isai",
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w300,
    //                             color: Colors.white,
    //                           )
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
    //               ],
    //             ),
    //           ),
    //           );
    //     }

    //         Widget _Singles(){
    // return Card(
    //           shape: RoundedRectangleBorder(
    //             side: BorderSide(color: Colors.white70, width: 1),
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           elevation: 10,
    //           child: Container(
    //             height: 75,
    //             margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text("Isai",
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 22,
    //                         fontWeight: FontWeight.w300,
    //                       )
    //                     ),
    //                     Text("Distance: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Text("Speed: ",
    //                       style: TextStyle(
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w300,
    //                         color: Colors.white,
    //                       )
    //                     ),
    //                     Row(
    //                       children: <Widget>[
    //                         Text(" isai",
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w300,
    //                             color: Colors.white,
    //                           )
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
    //               ],
    //             ),
    //           ),
    //           );
    //     }

  Widget _menu(){
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom:25),
        children: <Widget>[
            Card(
              //color: Color(0xff60CECE),
              shape: RoundedRectangleBorder(
                // side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                margin: EdgeInsets.fromLTRB(17, 25, 0, 25),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xffFFCC00), Color(0xffFF6666)])),
                        //   // child: Center(
                        //   //   child: Icon(IconData(0xF3E6,fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage), size: 75, color: Colors.white,),
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text("Total Wins:",
                              style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 28,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ),
                            ],),
                            // Row(children: <Widget>[
                            //  Text("Time:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],),
                            //  Row(children: <Widget>[
                            //  Text("Distance:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],),
                            //  Row(children: <Widget>[
                            //  Text("Average Speed:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],),
                            // Text("Jump straight into the\nspeedometer and stop-\nwatch menu.",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w200,
                            //     color: Color(0xff838383),
                            //   )
                            // ),
                          ]
                        ),
                      ],
                    ),
                    //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
             Card(
               //color: Color(0xffFF6666),
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: Colors.white70, width: 1),
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
                        // Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xffFF6666), Color(0xff60CECE)])),
                        //   // child: Center(
                        //   //   child: Icon(Entypo.stopwatch, size: 65,color: Colors.white,)
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                        //   Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xffFF6666), Color(0xff60CECE)])),
                        //   // child: Center(
                        //   //   child: Icon(Entypo.stopwatch, size: 65,color: Colors.white,)
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                             Text("Total Miles:",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ), 
                            ],),
                            // Row(children: <Widget>[
                            //  Text("Total Miles:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],),
                            // Row(children: <Widget>[
                            //  Text("Best Time:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],),
                            //  Row(children: <Widget>[
                            //  Text("Best Speed:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ), 
                            // ],)
                            // Text("Race against the clock to\ncross the finish line.\nCompare with friends.",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w200,
                            //     color: Color(0xff838383),
                            //   )
                            // ),
                          ]
                        ),
                        
                      ],
                    ),
                    //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
            ),
            Card(
              //color: Color(0xffFFCC00),
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: Colors.white70, width: 1),
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
                        // Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xff60CECE), Color(0xff916DD5)])),
                        //   // child: Center(
                        //   //   child: Icon(Icons.people,size:65, color: Colors.white,),
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                        //        Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xff60CECE), Color(0xff916DD5)])),
                        //   // child: Center(
                        //   //   child: Icon(Icons.people,size:65, color: Colors.white,),
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                              Text("Total Calories:",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ),
                            ],),
                            // Row(children: <Widget>[
                            // Text("Wins:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),
                            // Row(children: <Widget>[
                            // Text("Points:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),
                            // Row(children: <Widget>[
                            // Text("Distance:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),
                            // Text("Multiplayer",
                            //   style: TextStyle(
                            //     fontSize: 34,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // Text("Connect with friends and\nplay games designed to\ntest your abilities.",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w200,
                            //     color: Color(0xff838383),
                            //   )
                            // ),
                          ]
                        ),
                        
                      ],
                    ),
                    //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                                ],
                ),
              ),
            ),
             Card(
               //color: Color(0xff916DD5),
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: Colors.white70, width: 1),
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
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                        //       Container(
                        //   width: 34,
                        //   height: 34,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [Color(0xff916DD5), Color(0xffFFCC00)])),
                        //   // child: Center(
                        //   //   child: Icon(Icons.person,size:65, color: Colors.white,),
                        //   // ),
                        // ),
                        // SizedBox(width:10),
                              Text("Average Speed:",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              )
                            ),
                            ],),
                            // Row(children: <Widget>[
                            // Text("Time:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),
                            // Row(children: <Widget>[
                            // Text("Points:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),
                            // Row(children: <Widget>[
                            // Text("Distance:",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w200,
                            //     color: Colors.black,
                            //   )
                            // ),
                            // ],),

                            
                            // Text("Solo player minigames.\nBeat your high score in\nthese assault bike games.",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w200,
                            //     color: Color(0xff838383),
                            //   )
                            // ),
                          ]
                        ),
                      ],
                    ),
                    //Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                  ],
                ),
              ),
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
              _title(),
              SizedBox(height:5),
              _profile(),
              _stats(),
              _menu(),
              // _Quickstart(),
              // _Trials(),
              // _Multiplayer(),
              // _Singles()
              // _grid(),
              // _trials()
            ],
          )
        ),
      ),
    );
  }
}
