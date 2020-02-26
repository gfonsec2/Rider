import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';
import 'Records.dart';

class Multiplayer extends StatefulWidget {
  @override
  _MultiplayerState createState() => _MultiplayerState();
}

class _MultiplayerState extends State<Multiplayer> {
  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Multiplayer",
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted, color: Colors.grey),
            title: Text('Records'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.grey),
            title: Text('Settings')
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _title(),
          ],
        )
      ),
    );
  }
}
