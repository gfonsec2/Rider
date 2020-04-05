import 'package:flutter/material.dart';
import 'package:rider/AboutUs.dart';
import 'package:rider/ChangePassword.dart';
import 'package:intl/intl.dart';
import 'splashscreen.dart';

class Settings extends StatefulWidget {
  Settings({Key key}): super(key: key);
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DateTime now = DateTime.now();
  _SettingsState({Key key});
  final List<String> entries = <String>['Change Password', 'Sign Out', 'About Us'];

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: <Widget>[
              _title(),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10),
                  children: <Widget>[
                    Divider(thickness: 2),
                    ListTile(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword()));},
                      leading: Icon(IconData(59543, fontFamily: 'MaterialIcons'),size: 35, color: Color(0xffffcc00)),
                      title: Text(
                        "Change Password",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Divider(thickness: 2),
                    ListTile(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => AboutUs()));},
                      leading: Icon(IconData(59534, fontFamily: 'MaterialIcons'), size: 35, color: Color(0xffffcc00)),
                      title: Text(
                        "About Us",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Divider(thickness: 2),
                    ListTile(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen()));},
                      leading: Icon(IconData(59513, fontFamily: 'MaterialIcons'), size: 35, color: Color(0xffffcc00)),
                      title: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Divider(thickness: 2),
                  ]
                )
              ),
            ],
          )
        ),
      ),
    );
  }
/*
  void _onItemTapped(int index) {
    setState(() {
      if(index == 0){
        Navigator.push(context,MaterialPageRoute(builder: (context) => MyTabbedPage()));
      }
      if(index == 1){
        Navigator.push(context,MaterialPageRoute(builder: (context) => MyTabbedPage()));
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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(8, 10, 8, 25),
                children: <Widget>[
                  Divider(thickness: 2),
                  ListTile(
                    leading: Icon(IconData(59543, fontFamily: 'MaterialIcons'),size: 35, color: Color(0xffffcc00)),
                    title: Text(
                      "Change Password",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    leading: Icon(IconData(59534, fontFamily: 'MaterialIcons'), size: 35, color: Color(0xffffcc00)),
                    title: Text(
                      "About Us",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen()));},
                    leading: Icon(IconData(59513, fontFamily: 'MaterialIcons'), size: 35, color: Color(0xffffcc00)),
                    title: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  Divider(thickness: 2),
                ]
              )
            ),
          ],
        )
      ),
    );
  }*/
}
