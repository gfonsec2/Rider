import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> anonLogin(String email, String password) async {
    
    AuthResult result  = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
    FirebaseUser user = result.user;
    print(user.uid);
    return user;
  }

  Future<void> createUserData(FirebaseUser user, String name, String username) {
    DocumentReference reportRef = _db.collection('users').document(user.uid);
    return reportRef.setData({
      'uid': user.uid,
      'email': user.email,
      'name': name,
      'username': username,
      'avgMph': 0,
      'totalMiles': 0,
      'totalCalories': 0,
      'totalTime':0,
      'totalWins':0,
      'lastActivity': DateTime.now(),
      'prevAvgMph': 0,
      'prevCalories': 0,
      'prevDistance': 0,
    });
  }

 


  Future<void> signOut() {
    return _auth.signOut();
  }

}

 Future<void> updateUserData(FirebaseUser user, double timeDone, int caloriesDone,  double milesDone) async {
    DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
    double miles,time;
    int calories;
    var snapshot = await reportRef.get();

    miles = snapshot['totalMiles'].toDouble();
    time = snapshot['totalTime'].toDouble();
    calories = snapshot['totalCalories'].toInt();

    Firestore.instance.collection('users').document(user.uid).updateData({
      'totalMiles': (miles + milesDone),
      'avgMph': (miles + milesDone) / ((time + timeDone)/60),
      'totalCalories': (calories + caloriesDone),
      'totalTime': (time + timeDone),
      'lastActivity': DateTime.now(),
      'trialDistance': milesDone
    });
  }
  



  Future<void> updatePrevWorkout(FirebaseUser user, double timeDone, int caloriesDone,  double milesDone) async {
    print("I am here");
    DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
    double miles,time;
    int calories;
    var snapshot = await reportRef.get();

    miles = snapshot['totalMiles'].toDouble();
    time = snapshot['totalTime'].toDouble();
    calories = snapshot['totalCalories'].toInt();

    Firestore.instance.collection('users').document(user.uid).updateData({
      'totalMiles': (miles + milesDone),
      'prevAvgMph': (milesDone)/(timeDone),
      'prevCalories': caloriesDone,
      'prevDistance': milesDone,
      'totalCalories': (calories + caloriesDone),
      'totalTime': (time + timeDone),
      'lastActivity': DateTime.now(),
    });
  }

  Future<void> updateMultiplayer(FirebaseUser user, double timeDone, int caloriesDone,  double milesDone) async {
    print("I am here");
    DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
    double miles,time;
    int calories;
    var snapshot = await reportRef.get();

    miles = snapshot['totalMiles'].toDouble();
    time = snapshot['totalTime'].toDouble();
    calories = snapshot['totalCalories'].toInt();

    Firestore.instance.collection('users').document(user.uid).updateData({
      'totalMiles': (miles + milesDone),
      'prevAvgMph': (milesDone) / ((timeDone)/60),
      'prevCalories': caloriesDone,
      'prevDistance': milesDone,
      'totalCalories': (calories + caloriesDone),
      'totalTime': (time + timeDone),
      'lastActivity': DateTime.now(),
    });
  }



void resetRead()
{
     FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').update({
        'startReading': 0,
        'Rotations': 0 
    });
    FirebaseDatabase.instance.reference().child("user2").child('rotations_per_minute_stream').update({
        'startReading': 0,
        'Rotations': 0 
    });

}

Future<double> getMiles(FirebaseUser user) 
async {
  
  DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
  var snapshot = await reportRef.get();
  double miles = 0;
  var m = snapshot['totalMiles'];

  return m.toDouble();

}