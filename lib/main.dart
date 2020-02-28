
//Assault Bike has a fan diameter of 25 inches
//Circumference of the fan is 78.5398 Inches -> 6.54498333 Feet
//One Roation = 6.54498333 Feet


// Used to call main.dart now splashscreen.dart
//Commented out everything and its at the bottom

import 'dart:async';
import 'package:flutter/material.dart';
import 'Login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
       Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(150.0))
                      //   ),
                        Image.asset("assets/OriRider.png",
                        width: 200,
                        height: 200,
                    
                        ),

                      // ),
                      
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       CircularProgressIndicator(
                      
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(top: 20.0),
              //       ),
              //       // Text(
              //       //   "Loading...",
              //       //   softWrap: true,
              //       //   textAlign: TextAlign.center,
              //       //   style: TextStyle(
              //       //       fontWeight: FontWeight.bold,
              //       //       fontSize: 18.0,
              //       //       color: Colors.black),
              //       // )
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'trackStarter.dart';
// import 'stopwatch.dart';
// import 'custom.dart';
// //Assault Bike has a fan diameter of 25 inches
// //Circumference of the fan is 78.5398 Inches -> 6.54498333 Feet
// //One Roation = 6.54498333 Feet

// void main() {
//   final timerService = TimerService();
//   runApp(TimerServiceProvider( // provide timer service to all widgets of your app
//       service: timerService,
//       child: MaterialApp(home: MyApp()),
//     ),);
// }

// class CustomSlider extends StatelessWidget {
//   double totalWidth = 200.0;
//   double percentage;
//   Color positiveColor;
//   Color negetiveColor;
 
//   CustomSlider({this.percentage, this.positiveColor, this.negetiveColor});
 
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: totalWidth + 4.0,
//       height: 30.0,
//       decoration: BoxDecoration(
//           color: negetiveColor,
//           border: Border.all(color: Colors.black, width: 2.0)),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Container(
//             color: positiveColor,
//             width: (percentage / 100) * totalWidth,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white10,
//         title: Text("Rider Tracks", style: TextStyle(fontSize: 40, color: Colors.white)),
//       ),
//       backgroundColor: Colors.white10,
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Card(color: Colors.greenAccent,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                    ),
//                        child: Container(
//                          height: 175,
//                          child: ListTile(
//                          // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
//                          title: Text('Beginner Track',textAlign:TextAlign.center, style: TextStyle(
//                            fontSize: 24.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white,
//                            )),
//                            subtitle: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Row(
//                                  children: <Widget>[
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                ],
//                                ),
//                              ],
//                            ),
//                          // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Easy Track", color: Colors.greenAccent, countdown: 10, totalRotations: 10, distance: 196.35)));
//                          },
//                          ),
//                        )
                      
//                      ),
//                 ),
//                 Expanded(
//                   child: Card(color: Colors.orangeAccent,
//                      shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                    ),
//                        child: Container(
//                          height: 175,
//                          child: ListTile(
//                          // leading: Icon(const IconData(59445, fontFamily: 'MaterialIcons')),
//                          title: Text('Median Track',textAlign:TextAlign.center, style: TextStyle(
//                            fontSize: 24.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white,
//                            )),
//                            subtitle: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Row(
//                                  children: <Widget>[
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                ],
//                                ),
//                               //  Text("Record: 27rpm", style: TextStyle(
//                               //    fontSize: 12.0,
//                               //    fontWeight: FontWeight.w400,
//                               //    color: Colors.black
//                               //  ),
//                               //  ),
//                              ],
//                            ),
//                          // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Intermediate Track", color: Colors.orangeAccent, countdown: 20, totalRotations: 80, distance: 523.60)));
//                          },
//                          ),
//                        )
//                      ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Card(color: Colors.redAccent,
//                      shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                    ),
//                        child: Container(
//                          height: 175,
//                          child: ListTile(
//                          // leading: Icon(const IconData(57676, fontFamily: 'MaterialIcons')),
//                          title: Text('Expert Track',textAlign:TextAlign.center, style: TextStyle(
//                            fontSize: 24.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white,
//                            )),
//                            subtitle: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Row(
//                                  children: <Widget>[
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                   Icon(Icons.star, color: Colors.yellowAccent),
//                                ],
//                                ),
//                               //  Text("Record: 456cal", style: TextStyle(
//                               //    fontSize: 12.0,
//                               //    fontWeight: FontWeight.w400,
//                               //    color: Colors.black
//                               //  ),
//                               //  ),
//                              ],
//                            ),
//                          // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Expert Track", color: Colors.redAccent, countdown: 40, totalRotations: 180, distance: 1178.09)));
//                          },
//                          ),
//                        )
//                      ),
//                 ),
//                 Expanded(
//                   child: Card(color: Colors.blueAccent,
//                      shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                    ),
//                        child: Container(
//                          height: 175,
//                          child: ListTile(
//                          // leading: Icon(const IconData(57528, fontFamily: 'MaterialIcons')),
//                          title: Text('Custom Track',textAlign:TextAlign.center, style: TextStyle(
//                            fontSize: 24.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white,
//                            )),
//                         subtitle: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Row(
//                                  children: <Widget>[
//                                   Icon(Icons.add_circle, color: Colors.yellowAccent),
//                                ],
//                                ),
//                               //  Text("Record: N/A", style: TextStyle(
//                               //    fontSize: 12.0,
//                               //    fontWeight: FontWeight.w400,
//                               //    color: Colors.black
//                               //  ),
//                               //  ),
//                              ],
//                            ),
//                          // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) => Custom(track: "Custom Track", color: Colors.blue)));
//                          },
//                          ),
//                        )
//                      ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Card(color: Colors.white,
//                      shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                    ),
//                        child: Container(
//                          height: 400,
//                          child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Center(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text("60",
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 40.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.w200,
//                                     ) 
//                                    ),
//                                    Text("cal",
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 40.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.w200,
//                                     ) 
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Center(
//                                child:  Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text('180',
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 50.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                     )
//                               ),
//                               Text('avg rpm',
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 50.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                     )
//                               ),
//                                  ],
//                                ),    
//                              ),
//                              Center(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text("120",
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 40.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.w200,
//                                     ) 
//                                    ),
//                                    Text("min",
//                                    textAlign:TextAlign.center,
//                                     style: TextStyle(
//                                             fontSize: 40.0,
//                                               color: Colors.black,
//                                                 fontWeight: FontWeight.w200,
//                                     ) 
//                                    ),
//                                  ],
//                                ),
//                              ),
//                           ],
//                          ),
//                        )
//                      ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       // body:Center(
//       //  child:Container(
        
//       //    margin: const EdgeInsets.all(15.0),
//       //      child: GridView.count(
//       //              crossAxisCount: 2,
//       //              crossAxisSpacing:4.0,
//       //              mainAxisSpacing:4.0,
//       //          children: <Widget>[
//       //              Card(color: Colors.greenAccent,
//       //              shape: RoundedRectangleBorder(
//       //                borderRadius: BorderRadius.circular(25.0),
//       //              ),
//       //                  child: ListTile(
//       //                  // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
//       //                  title: Text('Beginner Track',textAlign:TextAlign.center, style: TextStyle(
//       //                    fontSize: 24.0,
//       //                    fontWeight: FontWeight.bold,
//       //                    color: Colors.white,
//       //                    )),
//       //                    subtitle: Row(
//       //                      children: <Widget>[
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Text(" Easy",textAlign:TextAlign.center, style: TextStyle(
//       //                          fontSize: 16.0,
//       //                          color: Colors.white))
//       //                      ],
//       //                    ),
//       //                  // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//       //                  onTap: () {
//       //                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Easy Track", color: Colors.greenAccent, countdown: 10, totalRotations: 10, distance: 196.35)));
//       //                  },
//       //                  )
                      
//       //                ),
//       //                Card(color: Colors.orangeAccent,
//       //                shape: RoundedRectangleBorder(
//       //                borderRadius: BorderRadius.circular(25.0),
//       //              ),
//       //                  child: ListTile(
//       //                  // leading: Icon(const IconData(59445, fontFamily: 'MaterialIcons')),
//       //                  title: Text('Median Track',textAlign:TextAlign.center, style: TextStyle(
//       //                    fontSize: 24.0,
//       //                    fontWeight: FontWeight.bold,
//       //                    color: Colors.white,
//       //                    )),
//       //                    subtitle: Row(
//       //                      children: <Widget>[
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Text("Medium",textAlign:TextAlign.center, style: TextStyle(
//       //                          fontSize: 16.0,
//       //                          color: Colors.white))
//       //                      ],
//       //                    ),
//       //                  // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//       //                  onTap: () {
//       //                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Intermediate Track", color: Colors.orangeAccent, countdown: 20, totalRotations: 80, distance: 523.60)));
//       //                  },
//       //                  )
//       //                ),
//       //                Card(color: Colors.redAccent,
//       //                shape: RoundedRectangleBorder(
//       //                borderRadius: BorderRadius.circular(25.0),
//       //              ),
//       //                  child: ListTile(
//       //                  // leading: Icon(const IconData(57676, fontFamily: 'MaterialIcons')),
//       //                  title: Text('Expert Track',textAlign:TextAlign.center, style: TextStyle(
//       //                    fontSize: 24.0,
//       //                    fontWeight: FontWeight.bold,
//       //                    color: Colors.white,
//       //                    )),
//       //                    subtitle: Row(
//       //                      children: <Widget>[
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Icon(Icons.star, color: Colors.yellowAccent),
//       //                        Text("Hard",textAlign:TextAlign.center, style: TextStyle(
//       //                          fontSize: 16.0,
//       //                          color: Colors.white))
//       //                      ],
//       //                    ),
//       //                  // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//       //                  onTap: () {
//       //                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackStarter(track: "Expert Track", color: Colors.redAccent, countdown: 40, totalRotations: 180, distance: 1178.09)));
//       //                  },
//       //                  )
//       //                ),
//       //                Card(color: Colors.blueAccent,
//       //                shape: RoundedRectangleBorder(
//       //                borderRadius: BorderRadius.circular(25.0),
//       //              ),
//       //                  child: ListTile(
//       //                  // leading: Icon(const IconData(57528, fontFamily: 'MaterialIcons')),
//       //                  title: Text('Custom Track',textAlign:TextAlign.center, style: TextStyle(
//       //                    fontSize: 24.0,
//       //                    fontWeight: FontWeight.bold,
//       //                    color: Colors.white,
//       //                    )),
//       //                  subtitle: Row(
//       //                      children: <Widget>[
//       //                        Icon(Icons.add_circle, color: Colors.yellowAccent),
//       //                        Text(" Custom",textAlign:TextAlign.center, style: TextStyle(
//       //                          fontSize: 16.0,
//       //                          color: Colors.white))
//       //                      ],
//       //                    ),
//       //                  // trailing: Icon(const IconData(58849, fontFamily: 'MaterialIcons', matchTextDirection: true)),
//       //                  onTap: () {
//       //                    Navigator.push(context, MaterialPageRoute(builder: (context) => Custom(track: "Custom Track", color: Colors.blue)));
//       //                  },
//       //                  )
//       //                ),
//       //              ],
//       //            ),
//       // ),
    
     


//     );
//   }
// }