import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';

class Records extends StatefulWidget {
  final int selectedIndex;
  Records({Key key, @required this.selectedIndex}): super(key: key);
  _RecordsState createState() => _RecordsState(selectedIndex: selectedIndex);
}

class _RecordsState extends State<Records> {
  final int selectedIndex;
  _RecordsState({Key key, @required this.selectedIndex});
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
      if(index == 2){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Settings(selectedIndex: 2)));
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
          ],
        )
      ),
    );
  }
}
