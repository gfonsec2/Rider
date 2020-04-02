import 'package:flutter/material.dart';
import 'package:rider/Login.dart';
import 'Connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  String name ="", username="";
  bool _obscurePassword = true;
  bool _obscure = true;
  bool _obscureEmailError = true;
  final databaseReference = Firestore.instance;

  @override
  String _invalidEmail(){
    return _obscureEmailError ? 'Invalid Email Format' : 'Email in use by another account';
  }

  Widget _emailEditContainer() {
    return  Container(
      child:  TextFormField(
        // controller: _userId,
        validator: (input) {
          if(input.isEmpty){
            setState(() {
              _obscure = true;
            });
            return 'Provide an Email';
          }
          else{
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (input) => _email = input,
        decoration:  InputDecoration(
          labelText: 'Email',
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true
        ),
      ),
    );
  }

  Widget _nameEditContainer() {
    return  Container(
      child:  TextFormField(
        textCapitalization: TextCapitalization.words,
        // controller: _userId,
        validator: (input) {
          if(input.isEmpty){
            return 'Provide a Name';
          }
          else{
            return null;
          }
        },
        onSaved: (input) => name = input,
        decoration:  InputDecoration(
          labelText: 'Full Name',
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true
        ),
      ),
    );
  }

  Widget _userIDEditContainer() {
    return  Container(
      child:  TextFormField(
        validator: (input) {
          if(input.isEmpty){
            return 'Provide a Username';
          }
          else{
            return null;
          }
        },
        onSaved: (input) => username = input,
        decoration:  InputDecoration(
          labelText: 'Username',
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true
        ),
      ),
    );
  }

  Widget _passwordEditContainer() {
    return  Container(
      child:  TextFormField(
        validator: (input) {
          if(input.isEmpty){
            return 'Provide a Password';
          }
          else if(input.length < 8){
            return 'Password must be over 8 characters';
          }
          else{
            return null;
          }
        },
        onSaved: (input) => _password = input,
        obscureText: _obscurePassword,
        decoration:  InputDecoration(
          labelText: 'Password',
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            child: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              semanticLabel: _obscurePassword ? 'show password' : 'hide password',
            ),
          ),
        ),
      ),
    );
  }

 Widget _loginContainer(context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          signUp(context);
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
              "Sign Up",
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
              SizedBox(height: 5),
              _emailEditContainer(),
              SizedBox(height: 12), 
              _nameEditContainer(),
              SizedBox(height: 12),
              _userIDEditContainer(),
              SizedBox(height: 12),
              _passwordEditContainer(),
              SizedBox(height: 12),
              _loginContainer(context),
              SizedBox(height: 12),
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
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  //Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
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
                )
              ),
            ],
          ),
        ),
      )
    );
  }

  void change(context){
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
        setState(() {
          if(e.message == 'The email address is badly formatted.'){
            _obscureEmailError = true;
            _obscure = false;
          }
          else if(e.message == 'The email address is already in use by another account.'){
            _obscureEmailError = false;
            _obscure = false;
          }
        });
      }
    }
  }

  void createRecord(String user, String name,String username) async {
    await databaseReference.collection("users")
      .document(user.toString())
      .setData({
        'name': name,
        'username': username
      }
    );
  }
}
