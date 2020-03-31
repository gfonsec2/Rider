import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
      'lastActivity': DateTime.now()
    });
  }

 


  Future<void> signOut() {
    return _auth.signOut();
  }

}

 Future<void> updateUserData(FirebaseUser user, double timeDone, double totalTime, double caloriesDone, 
  double doneMiles, double milesDone) async {
    DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
    double miles,time,calories;
    var snapshot = await reportRef.get();

    miles = snapshot['totalMiles'];
    time = snapshot['totalTime'];
    calories = snapshot['totalCalories'];

    print(miles);
     print(calories);
      print(time);
    return reportRef.setData({
      'uid': user.uid,
      'email': user.email,
      'totalMiles': (miles + milesDone),
      'avgMph': (miles + milesDone) / (time + timeDone),
      'totalCalories': (calories + caloriesDone),
      'totalTime': (time + timeDone),
      'lastActivity': DateTime.now()
    });


  }

Future<double> getMiles(FirebaseUser user) 
async {
  
  DocumentReference reportRef = Firestore.instance.collection('users').document(user.uid);
  var snapshot = await reportRef.get();
  double miles = 0;
  var m = snapshot['totalMiles'];
print(m.toString());
  return m.toDouble();

}