import 'dart:async';
import 'package:flutter/material.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
       Navigator.pushReplacement(
    context,
    // MaterialPageRoute(builder: (context) => LoginPage()),
        MaterialPageRoute(builder: (context) => LoginPage()),

  );
    });
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      body:  Hero(
        tag: 'Isai',
        
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                        height: 105.0,
                                        width: 105.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCC00),
                                          borderRadius: BorderRadius.all( Radius.circular(150.0)),
                                        ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text("R", style: TextStyle(fontSize: 95,fontFamily: "Marker Felt"  , color: Colors.white), )
                                      ],
                                    ),
                                  )
                                      ],
                                    ),
                          //   Image.asset("assets/OriRider.png",
                          //   width: 200,
                          //   height: 200,
                        
                          //   ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  
  //     body: Hero(
  //       tag: 'imageHero',
  //       child: Image.asset(
  //           'assets/OriRider.png',
  //         ),
  //         transitionOnUserGestures: true,
  //         flightShuttleBuilder: (flightContext, animation, direction,
  //     fromContext, toContext) {
  //   return Image.asset(
  //           'assets/OriRider.png',
  //         );
  // },
  //     ),
    );
  }
}


// class DetailScreen extends StatefulWidget {
//   @override
//   _DetailScreenState createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Center(
//           child: Image.asset(
//             'assets/OriRider.png',
//           ),
//         ),
//       ),
//     );
//   }
// }


// class SplashScreen extends StatefulWidget {
//   _SplashScreenState createState() => _SplashScreenState();
  
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5), () {
//        Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => LoginPage()),
//   );
//     });
//   }


// @override Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           fit: StackFit.expand,
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(color: Colors.white),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                           Image.asset("assets/OriRider.png",
//                           width: 200,
//                           height: 200,
                      
//                           ),
                        
//                         CircularProgressIndicator(),
//                         Padding(
//                           padding: EdgeInsets.only(top: 10.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               ],
//             )
//           ],
//         ),
      
//     );
//   }
// }


