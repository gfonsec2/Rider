import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Singles extends StatefulWidget {
  @override
  _SinglesState createState() => _SinglesState();
}

class _SinglesState extends State<Singles> {
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
          child: Text("Singles",
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
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          children: <Widget>[
            _back(),
            _title(),
          ],
        )
      ),
    );
  }
}
