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
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed:(){
         signIn(context);
        },
        color: Colors.blue[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text(
          "Log In",
          style:  TextStyle(color: Colors.white, fontSize: 15),
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
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                child: Image.asset(
                  "assets/OriRider.png",
                  width: 225,
                  height: 225,
                )
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
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
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
