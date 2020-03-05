import 'package:flutter/material.dart';
import 'package:rider/main.dart';
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
  }
}
