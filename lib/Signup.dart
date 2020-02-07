import 'package:flutter/material.dart';
import 'Connection.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget _userIDEditContainer() {
    return new Container(
      child: new TextField(
        // controller: _userId,
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
      child: new TextField(
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
      child: new TextField(
        // controller: _password,
        obscureText: true,
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
      child: new TextField(
        // controller: _password,
        obscureText: true,
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
      onPressed:(){
        Navigator.push(context,MaterialPageRoute(builder: (context) => ConnectionPage()));
      },
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

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(30.0),
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
    ));
  }
}
