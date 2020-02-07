import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
       currentIndex: 0, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           backgroundColor: Colors.grey,
           icon: Icon(Icons.home),
           title: Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.menu),
           title: Text('Menu')
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           title: Text('Settings')
         ),
       ],
      ),
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.all(50),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Home",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  )),
              Text("Wednesday, February 5",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
              SizedBox(height: 50),
              Text("Previous Workout",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(children: <Widget>[
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("213",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            )),
                        Text("60.2",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("1.56",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Calories",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            )),
                        Text("RPM",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("Distance",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            )),
                      ],
                    ),
                  ])),
              Container(
                height: 351, //Causes a problem when not the right height
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    children: <Widget>[
                      Card(
                          color: Colors.red[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
                            title: Text('Manual',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          )),
                          Card(
                          color: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
                            title: Text('Trials',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          )),
                          Card(
                          color: Colors.yellow[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
                            title: Text('Singles',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          )),
                          Card(
                          color: Colors.green[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            // leading: Icon(const IconData(59499, fontFamily: 'MaterialIcons')),
                            title: Text('Multiplayer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          )),
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}
