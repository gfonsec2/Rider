import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';
import 'Records.dart';

class QuickStart extends StatefulWidget {
  @override
  _QuickStartState createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart> {

  Widget _title (){
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding:const EdgeInsets.all(23.0)),
          Row(
            children: <Widget>[
              Padding(padding:const EdgeInsets.only(left: 15.0)),
              Text("Quick Start",
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding:const EdgeInsets.only( left: 15.0),),
              Text("Tuesday, January 21",
              style: TextStyle(fontSize: 22, 
                color: Colors.grey
              ),
              )
            ], 
          ),
        ],
      ),
    );
  }

  Widget _mph(){
    return Stack(
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
    );
  }

  Widget _dist(){
    return Stack(
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
    );
  }

  Widget _cal(){
      return Stack(
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
    );
  }

  Widget _card(context){
    return Container(
      height: 225,
      width: 400,
      child: Container(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0)
        // ),
        // elevation: 10,
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("00:00.00",
                style: TextStyle( fontSize: 80),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Elapsed Time",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
                ),
              ],
            ),
            SizedBox(
              height:30
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(      
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.black
                      ),
                  child: Text("Cancel"),
                  onPressed: () {Navigator.pop(context);}
                )
                  ],
                ),
                SizedBox(
                  width: 50
                ),
                Row(
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.black
                      ),
                  child: Text("Start"),
                  onPressed: () {Navigator.pop(context);}
                )
                  ],
                ),
            ],
            ),
            
          ],
        ),
      ),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      if(index == 0){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Home(selectedIndex: 0)));
      }
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
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.grey,
      //   onTap: _onItemTapped,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home, color: Colors.grey),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.format_list_bulleted, color: Colors.grey),
      //       title: Text('Records'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings, color: Colors.grey),
      //       title: Text('Settings')
      //     ),
      //   ],
      // ),
      body: Container(
      // margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          _title(),
          SizedBox(
            height: 18,
          ),
          _mph(),
          SizedBox(
            height: 9,
          ),
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(20.0)),
              _dist(),
              SizedBox(
                width: 80,
              ),
              _cal(),
            ],
          ),
          SizedBox(
                height:20 ,
              ),
          _card(context)
        ],
      ),

      ),
      // body: Container(
      //   margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
      //   child: Column(
      //     children: <Widget>[

      //     ],
      //   )
      // ),
    );
  }
}
