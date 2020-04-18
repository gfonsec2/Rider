import 'package:flutter/material.dart';
import 'TrialStart.dart';
import 'package:intl/intl.dart';

class Trials extends StatefulWidget {
  @override
  _TrialsState createState() => _TrialsState();
}

class _TrialsState extends State<Trials> {
  final List<int> seconds = <int>[60,60,60,120,120,120,300,600,1200];
  final List<String> name = <String>["1 - minute Warmup","1 - minute Warmup","1 - minute Warmup","2 - minute Light Cardio","2 - minute Light Cardio","2 - minute Light Cardio","5 - minute Intense Cardio","10 - minute Intense Cardio","20 - minute Intense Cardio"];
  final List<double> distance = <double>[0.25,0.5,0.75,1,1.5,2,3,5,10];
  final List<int> speed = <int>[12,12,12,21,23,25,25,26,27];
  final List<String> difficulty = <String>["Beginner","Beginner","Beginner","Intermediate","Intermediate","Intermediate","Advanced","Advanced","Advanced"];
  final List<Color> color = <Color>[Color(0xff85B684),Color(0xff85B684),Color(0xff85B684),Color(0xffFFCC00),Color(0xffFFCC00),Color(0xffFFCC00),Color(0xffFF6666),Color(0xffFF6666),Color(0xffFF6666)];
  DateTime now = DateTime.now();

  Widget _back(){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Row(
        children: <Widget>[
          Icon(IconData(58848, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 13),
          Text("Back"),
        ],
      )
    );        
  }
  
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

  Widget _trials(){
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: name.length,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        itemBuilder: (BuildContext context, int index) {
        return
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => TrialStart(title: "${name[index]}", goal: distance[index], start: seconds[index], current: seconds[index],)));
            },
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
                        Text("${name[index]}",
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
              _back(),
              _title(),
              _trials()
            ],
          )
        ),
      ),
    );
  }
}
