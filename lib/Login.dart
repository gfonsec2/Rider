import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Signup.dart';
import 'Connection.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  Widget _userIDEditContainer() {
    return new Container(
      child: new TextFormField(
         validator: (input)
         {
          if(input.isEmpty){
            return 'Provide an email';
          }
            },
            onSaved: (input) => _email = input,
        // controller: _userId,
        decoration: new InputDecoration(
            hintText: 'Email',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
            ),
            isDense: true),
        // style: _textStyleBlack,
      ),
    );
  }

  Widget _passwordEditContainer() {
    return new Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: new TextFormField(
         validator: (input) {
          if(input.isEmpty){
            return 'Provide a password';
          }
            },
            onSaved: (input) => _password = input,
        // controller: _password,
        obscureText: true,
        decoration: new InputDecoration(
            hintText: 'Password',
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: new BorderSide(color: Colors.black),
            ),
            isDense: true),
        // style: _textStyleBlack,
      ),
    );
  }

  Widget _loginContainer(context) {
    return FlatButton(
      onPressed:(){
       signIn(context);
      },
      child: Container(
        decoration: BoxDecoration(
                        gradient: LinearGradient(
                colors: [Color(0xffFFCC00), Color(0xffFF6666)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          borderRadius: BorderRadius.circular(5.0),
          // color: Colors.blue[300],
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0),
        width: 500.0,
        height: 40.0,
        child: new Text(
          "Log In",
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
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
              _userIDEditContainer(),
              SizedBox(
      height: 12,
              ),
              _passwordEditContainer(),
              SizedBox(
      height: 12,
              ),
              _loginContainer(context),
              SizedBox(
      height: 12,
              ),
              Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Text(
            'Forgot your login details?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          FlatButton(
            onPressed: () {},
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
            style: new TextStyle(color: Colors.grey),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
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
            ),),
            ],
          ),
    ),
        ));
  }
  void signIn(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        print("i am here");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConnectionPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
