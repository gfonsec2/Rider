import 'package:flutter/material.dart';
import 'Connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class SignUpPage extends StatelessWidget {
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      String _email, _password;
      String name ="", username="";
      final databaseReference = Firestore.instance;

  @override
  Widget _userIDEditContainer() {
    return new Container(
      child: new TextFormField(
          // controller: _userId,
           validator: (input) {
          if(input.isEmpty){
            return 'Provide an username';
          }
          },
          onSaved: (input) => username = input,
          decoration: new InputDecoration(
      hintText: 'Username',
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
          if(input.length < 6){
            return 'Longer password please';
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

  Widget _NameEditContainer() {
    return new Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: new TextFormField(
          validator: (input) {
          if(input.isEmpty){
            return 'Provide a name';
          }
          },
          onSaved: (input) => name = input,
          // controller: _password,
          decoration: new InputDecoration(
      hintText: 'Full Name',
      border: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: new BorderSide(color: Colors.black),
      ),
      isDense: true),
          // style: _textStyleBlack,
        ),
    );
  }

  Widget _EmailEditContainer() {
    return new Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: new TextFormField(
          validator: (input) {
          if(input.isEmpty){
            return 'Provide an email';
          }
            },
            onSaved: (input) => _email = input,
          // controller: _password,
          decoration: new InputDecoration(
      hintText: 'Email',
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
      onPressed: () => 
        signUp(context),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue[300],
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0),
        width: 500.0,
        height: 40.0,
        child: new Text(
          "Sign up",
          style: new TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                child: Image.asset(
                  "assets/OriRider.png",
                  width: 225,
                  height: 225,
                )),
            _EmailEditContainer(),
            SizedBox(
              height: 12,
            ), 
            _NameEditContainer(),
            SizedBox(
              height: 12,
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
              // children: <Widget>[],
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
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Sign in',
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
                )),
          ],
        ),
      ),
    ));
  }
  void change(context)
  {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ConnectionPage()));
  }
  void signUp(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
       AuthService auth1 = AuthService();
      var u =  await auth1.anonLogin(_email, _password);
        auth1.createUserData(u,name, username);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConnectionPage()));

      }catch(e){
        print(e.message);
      }
    }
  }


     /*void signUp(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        createRecord(user.uid, name, username);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ConnectionPage()));
      }catch(e){
        print(e.message);
      }
    }
  }*/

  void createRecord(String user, String name,String username) async {

  await databaseReference.collection("users")
      .document(user.toString())
      .setData({
        'name': name,
        'username': username
      });
}
}
