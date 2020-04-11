import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'Connection.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter/services.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _obscure = true;
  bool _obscureEmailError = true;

  int _code(){
    final _random = new Random();
    int next(int min, int max) => min+_random.nextInt( max - min);
    return next(1000, 9999);
  }

  final _subjectController = TextEditingController(text: 'Rider Password Reset Code');

  final _recipientController = TextEditingController(
    text: 'gibbyfonseca74@yahoo.com',
  );

  bool isHTML = false;

Future<void> send() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    final MailOptions mailOptions = MailOptions(
      body: _code().toString(),
      subject: _subjectController.text,
      recipients: <String>['gibbyfonseca74@yahoo.com'],
      isHTML: true,
    );

    String platformResponse;

    try {
      await FlutterMailer.send(mailOptions);
      platformResponse = 'success';
      print("success");
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
      if (!mounted){ 
        return;
      }
    } catch (error) {
      platformResponse = error.toString();
      print(platformResponse);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted){ 
      return;
    }
  }
  Widget _invalidEmail(){
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        _obscureEmailError ? '': 'Invalid Email',
        style: TextStyle(
          color: Colors.red
        ),
      ),
    );
  }

  Widget _emailPromptText(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Icon(IconData(58837, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Password Reset",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffcc00),
                )
              ),
            ],
          ),
        ),
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text("In order to reset your password, please enter your email below. You will receive and email with a code. Enter the code below to reset your password."),
                  SizedBox(height: 5),
                  _invalidEmail(),
                  SizedBox(height: 5),
                  Container(
                    child:  TextFormField(
                      validator: (input){
                        if(input.isEmpty){
                          setState(() {
                            _obscureEmailError = true;
                          });
                          return 'Email is required';
                        }
                        else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (input) => _email = input,
                      // controller: _userId,
                      decoration:  InputDecoration(
                        labelText: "Email",
                        //hintText: 'Email',
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:  BorderSide(color: Colors.black),
                        ),
                        isDense: true),
                      // style: _textStyleBlack,
                    ),
                  ),
                  SizedBox(height: 5),
                  RaisedButton(
                    onPressed: () {
                      send();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 40.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Send Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          )
        ),
      ]
    );
  }

  Widget _enterCodeCard() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Icon(IconData(58835, fontFamily: 'MaterialIcons'), size: 22, color: Color(0xffffcc00)),
              Text("Password Reset",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffcc00),
                )
              ),
            ],
          ),
        ),
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text("Enter the four-digit code sent to your email below."),
                  SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child:  TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        if(input.isEmpty){
                          setState(() {
                            _obscure = true;
                          });
                          return "Code is required";
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (input) => _password = input,
                      // controller: _password,
                      decoration:  InputDecoration(
                        labelText: "Code",
                        //hintText: 'Password',
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:  BorderSide(color: Colors.black),
                        ),
                        isDense: true,
                        counterText: "",
                      ),
                      maxLength: 4,
                      // style: _textStyleBlack,
                    ),
                  ),
                  SizedBox(height: 5),
                  RaisedButton(
                    onPressed: () {
                      signIn(context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 40.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Enter",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          )
        ),
      ]
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                                          Column(
                      children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Stack(
                           alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                        height: 105.0,
                                        width: 105.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFCC00),
                                          borderRadius: BorderRadius.all( Radius.circular(150.0)),
                                        ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text("R", style: TextStyle(fontSize: 95,fontFamily: "Marker Felt"  , color: Colors.white), )
                                      ],
                                    ),
                                  )
                                      ],
                        ),
                       
                        Text("i", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)),),
                        Text("d", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)),),
                        Text("e", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)),),
                        Text("r", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)),),
                        ],
                        ),
                        ],
                      ),
                      //Text("Rider", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)  ),)
                    ],
                  ),
                )
                // Image.asset(
                //   "assets/OriRider.png",
                //   width: 225,
                //   height: 125,
                // )
              ),
              _emailPromptText(),
              _enterCodeCard(),
              Container(
                alignment: Alignment.center,
                // height: 50.0,
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 17.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }

  void sendEmailCode(context){
    print(_code);
  }

  void signIn(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        //print("i am here");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConnectionPage()));
      }catch(e){
        //print(e.message);
        setState(() {
          _obscureEmailError = false;
        });
      }
    }
  }
}
