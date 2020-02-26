import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';
import 'Records.dart';

class Trials extends StatefulWidget {
  @override
  _TrialsState createState() => _TrialsState();
}

class _TrialsState extends State<Trials> {
final List<int> time = <int>[1,1,1,2,2,2,3,3,3];
final List<String> name = <String>["Warmup","Warmup","Warmup","Light Cardio","Light Cardio","Light Cardio","Intense Cardio","Intense Cardio","Intense Cardio"];
final List<double> distance = <double>[0.25,0.5,0.75,1,1.5,2,2.25,2.5,3];
final List<int> speed = <int>[12,12,12,21,23,25,25,26,27];
final List<int> colorCodes = <int>[600, 500, 100];
final List<String> difficulty = <String>["Beginner","Beginner","Beginner","Intermediate","Intermediate","Intermediate","Advanced","Advanced","Advanced"];
final List<Color> color = <Color>[Color(0xff85B684),Color(0xff85B684),Color(0xff85B684),Color(0xffFFCC00),Color(0xffFFCC00),Color(0xffFFCC00),Color(0xffFF6666),Color(0xffFF6666),Color(0xffFF6666)];
  Widget _title(){
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Trials",
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: name.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                return
                  GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(17, 15, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("${time[index]} - minute ${name[index]}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  )
                                ),
                                Text("Distance: ${distance[index]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  )
                                ),
                                Text("Speed: ${speed[index]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  )
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                          color: color[index],
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Text("${difficulty[index]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(IconData(58377, fontFamily: 'MaterialIcons', matchTextDirection: true)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              )
            )
          ],
        )
      ),
    );
  }
}
