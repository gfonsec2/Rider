import 'package:flutter/material.dart';
import 'Home.dart';

class ConnectionPage extends StatelessWidget {
  
  final text = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: TextStyle(
            fontSize: 35, color: Colors.black,
            fontWeight: FontWeight.w200
          ),
          children: <TextSpan>[
            TextSpan(text: "Connect the "),
            TextSpan(
                text: "Rider Sensor",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " to your phone or tablets auxiliary jack and "),
            TextSpan(
                text: "pedal ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " to test your connection."),
          ]
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe60CECE),
      body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Text(
                "Connection Test",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 90,
                child: Container(
                  alignment: Alignment.center,
                  child: FloatingActionButton(onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  })
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: text,
                alignment: Alignment.center,
                width: 315,
              ),
            ],
          )),
    );
  }
}