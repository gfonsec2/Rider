import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rider/SinglesGameStart.dart';

class Singles extends StatefulWidget {
  Singles({Key key}): super(key: key);
  @override
  _SinglesState createState() => _SinglesState();
}

class _SinglesState extends State<Singles> {
  DateTime now = DateTime.now();
  TextEditingController _controller;
  double _distance=0;
  String _dist="";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget _game(double miles, String prompt, Color upper, Color lower){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(title: prompt, totalDistance: miles, numMiles: miles.toString())));
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
              Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [upper, lower])),
                    child: Center(
                      child: Text("$miles mi.",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                  SizedBox(width:20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(prompt,
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Complete $prompt as\nfast as you can!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff838383),
                        )
                      ),
                    ]
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

  Widget _inputMiles(){
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
        child:  TextFormField(
          onSaved: (input) => _dist = input,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          maxLength: 2,
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          //onSaved: (input) => _email = input,
          decoration:  InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            counterText: "",
            labelText: "Miles",
            labelStyle: TextStyle(color: Colors.white),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(color: Colors.white),
            ),
            isDense: true),
          // style: _textStyleBlack,
        ),
      ),
    );
  }

  Widget _customGame(BuildContext context){
    return GestureDetector(
      onTap: (){
        custom(context);
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
              Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff000000), Color(0xffFF6666)])),
                    child: Center(
                      child: _inputMiles(),
                    ),
                  ),
                  SizedBox(width:20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Custom",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 34,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        )
                      ),
                      Text("Set your own distance and\ncomplete it as fast as you can!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff838383),
                        )
                      ),
                    ]
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
              _game(0.5, "Half Mile", Color(0xff916DD5), Color(0xffFFCC00)),
              _game(1, "1 Mile", Color(0xffFFCC00), Color(0xffFF6666)),
              _game(2, "2 Miles", Color(0xffFF6666), Color(0xff60CECE)),
              _game(3, "3 Miles", Color(0xff60CECE), Color(0xff916DD5)),
              _customGame(context),
            ],
          )
        ),
      ),
    );
  }

  custom(BuildContext context){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      _distance = double.parse(_dist);
      Navigator.push(context,MaterialPageRoute(builder: (context) => SinglesGameStart(title: "$_dist Miles", totalDistance: _distance, numMiles: _distance.toString())));
    }
  }
}