import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider/newHome.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';


class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}): super(key: key);
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  String _password, _confirmPassword;
  bool _obscureError = true;
  bool _obscureText = true;
  bool _obscureText2 = true;

  _ChangePasswordState({Key key});
  
  showAlertDialog(BuildContext context, FirebaseUser user) {
    Widget buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          child: Text("OK",
            style: TextStyle(
              color: Colors.blue[300],
              fontSize: 25,
            )
          ),
          onPressed:  () {Navigator.pop(context);Navigator.pop(context); },
        )
      ]
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text("Success!",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height:130,
        child: Column(
          children: <Widget>[
            Text("Your password has been reset.",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200
              )
            ),
            Container(
              child: buttons
            )
          ],
        ),
      )
      //Text("You're about to exit the Quick Start session. Would you like to save session?"),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _back(){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context,MaterialPageRoute(builder: (context) => Settings()));
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
          child: Text("Change Password",
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
  
  Widget _disclosure(){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        color: Colors.orangeAccent,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text("Disclosure",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
                SizedBox(height: 15),
                Text("Password might not be changeable since this operation is sensitive and requires recent authentication. Log in again before retrying this request.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordsDontMatch(){
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        _obscureError ? '': 'Passwords Do Not Match',
        style: TextStyle(
          color: Colors.red
        ),
      ),
    );
  }

  Widget _newPassword() {
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
          else if(input.length < 8){
            setState(() {
              _obscureError = true;
            });
            return 'Password must be over 8 characters';
          }
          else{
            return null;
          }
        },
        onSaved: (input) => _password = input,
        // controller: _password,
        obscureText: _obscureText,
        decoration:  InputDecoration(
          labelText: "New Password",
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

  Widget _confirmNewPassword() {
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
          else if(input.length < 8){
            setState(() {
              _obscureError = true;
            });
            return 'Password must be over 8 characters';
          }
          else{
            return null;
          }
        },
        onSaved: (input) => _confirmPassword = input,
        obscureText: _obscureText2,
        decoration:  InputDecoration(
          labelText: "Confirm New Password",
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  BorderSide(color: Colors.black),
          ),
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText2 = !_obscureText2;
              });
            },
            child: Icon(
              _obscureText2 ? Icons.visibility : Icons.visibility_off,
              semanticLabel: _obscureText2 ? 'show password' : 'hide password',
            ),
          ),
        ),
        // style: _textStyleBlack,
      ),
    );
  }

  Widget _changePasswordButton() {
    return RaisedButton(
      onPressed: () {
        _changePassword(_password);
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
            "Change Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
          child: Column(
            children: <Widget>[
              _back(),
              _title(),
              SizedBox(height: 5),
              _disclosure(),
              SizedBox(height: 15),
              _passwordsDontMatch(),
              SizedBox(height: 15),
              _newPassword(),
              SizedBox(height: 15),
              _confirmNewPassword(),
              SizedBox(height: 15),
              _changePasswordButton(),
            ],
          )
        ),
      ),
    );
  }

  void _change(String password){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      _changePassword(password);
    }
  }

  void _changePassword(String password) async{
    if(_password == _confirmPassword){
      try{
        //Create an instance of the current user. 
        FirebaseUser user = await FirebaseAuth.instance.currentUser();

        //Pass in the password to updatePassword.
        user.updatePassword(password).then((_){
          print("Succesfull changed password");
          showAlertDialog(context, user);
        }).catchError((error){
          print("Password can't be changed" + error.toString());
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
        });
      }catch(e){
        print(e.message);
      }
    }
    else{
      setState(() {
        _obscureError = false;
      });
    }
  }
}