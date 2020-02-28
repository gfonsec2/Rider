import 'package:flutter/material.dart';
import 'Login.dart';
import 'Home.dart';
import 'Records.dart';

class Settings extends StatefulWidget {
  final int selectedIndex;
  Settings({Key key, @required this.selectedIndex}): super(key: key);
  _SettingsState createState() => _SettingsState(selectedIndex: selectedIndex);
}

class _SettingsState extends State<Settings> {
  final int selectedIndex;
  _SettingsState({Key key, @required this.selectedIndex});
  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Settings",
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        currentIndex: selectedIndex, // this will be set when a new tab is tapped
        selectedItemColor: Color(0xffffcc00),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size:35,),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,size:35,),
            title: Text('Records'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,size:35,),
            title: Text('Settings')
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _title(),
            FlatButton(
              onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: new Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue[300],
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0),
                width: 500.0,
                height: 40.0,
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
