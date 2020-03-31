
//Assault Bike has a fan diameter of 25 inches
//Circumference of the fan is 78.5398 Inches -> 6.54498333 Feet
//One Roation = 6.54498333 Feet


// Used to call main.dart now splashscreen.dart
//Commented out everything and its at the bottom

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider/splashscreen.dart';
import 'Login.dart';
import 'package:provider/provider.dart';

import 'auth.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      StreamProvider<FirebaseUser>.value(value: AuthService().user),
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen() 
      ),
    );
  }
}