import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider/ForgotPassword.dart';
import 'Signup.dart';
import 'Connection.dart';

//Test user
//email: test@test.com
//password: 12345678
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _obscureText = true;
  bool _obscureError = true;

  Widget _wrongEmailOrPassword(){
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        _obscureError ? '': 'Invalid Email or Password',
        style: TextStyle(
          color: Colors.red
        ),
      ),
    );
  }

  Widget _userIDEditContainer() {
    return  Container(
      child:  TextFormField(
         validator: (input){
          if(input.isEmpty){
            setState(() {
              _obscureError = true;
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
    );
  }

  Widget _passwordEditContainer() {
    return  Container(
      padding: const EdgeInsets.only(top: 5.0),
      child:  TextFormField(
        validator: (input) {
          if(input.isEmpty){
            setState(() {
              _obscureError = true;
            });
            return "Password is required";
          }
          else{
            return null;
          }
        },
        onSaved: (input) => _password = input,
        // controller: _password,
        obscureText: _obscureText,
        decoration:  InputDecoration(
          labelText: "Password",
          //hintText: 'Password',
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              semanticLabel: _obscureText ? 'show password' : 'hide password',
            ),
          ),
        ),
        // style: _textStyleBlack,
      ),
    );
  }

  Widget _loginContainer(context) {
    return Container(
      child: RaisedButton(
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
              "Log In",
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
          //     Padding(
          // padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
              
              tag: "Isai",
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                // decoration: BoxDecoration(
                //   // color:Color(0xffFFCC00) ,
                //   color:Color(0xffFFCC00) ,
                //   borderRadius: BorderRadius.all( Radius.circular(150.0)),
                // ),
                // color: Colors.red,
                // child: Image.asset(
                //   "assets/OriRider.png",
                  width: 225,
                  height: 180,
                // ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Rider", style: TextStyle(fontSize: 95, fontFamily: "Marker Felt" ,color:Color(0xffFFCC00)  ),)
                  ],
                ),
              )
              ],
              
            )
            ),
          ),

              _wrongEmailOrPassword(),
              SizedBox(height: 5),
              _userIDEditContainer(),
              SizedBox(height: 12),
              _passwordEditContainer(),
              SizedBox(height: 12),
              _loginContainer(context),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Forgot your login details?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text(
                      'Get help signing in.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 2.7,
                    color: Colors.grey,
                  ),
                  Text(
                    ' OR ',
                    style:  TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 2.7,
                    color: Colors.grey,
                  ),
                ],
              ),
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
                                'Dont have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignUpPage()));
                                },
                                child: Text(
                                  'Sign up',
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

  void signIn(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //print("i am here");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConnectionPage()));
      }catch(e){
        //print(e.message);
        setState(() {
          _obscureError = false;
        });
      }
    }
  }
}
