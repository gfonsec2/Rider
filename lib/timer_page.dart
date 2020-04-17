import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/auth.dart';
import 'package:rider/newHome.dart';
import 'package:quiver/async.dart';
import 'dart:async';
import 'Home.dart';

FirebaseUser user;

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {

  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  // final TextStyle textStyle = const TextStyle(fontSize: 90.0 );
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  TimerPage({Key key,}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  
  final Dependencies dependencies = new Dependencies();

  showAlertDialog(BuildContext context) {
    
         
  Future<void> saveData()
  async {
    AuthService authService;
   // FirebaseUser user;

    double miles;
    int calories;
    var milliseconds = dependencies.stopwatch.elapsedMilliseconds;
    double minutes = milliseconds/60000;
    var va = await databaseReferencePulses.once().then((value) => 
    miles = (value.value.toInt()*50*3.14159/63360).toDouble());
    FirebaseDatabase.instance.reference().child("user").child('rotations_per_minute_stream').update({
        'startReading': 0,
        'Rotations': 0  //yes I know.
    });


      calories = await  (miles*50).toInt();
      updateUserData(user, minutes, calories, miles);
      Navigator.pop(context);
      Navigator.pop(context);

    }
    // set up the buttons
    Widget buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          child: Text("Cancel",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 25,
            )
          ),
          onPressed:  () => Navigator.pop(context)
        ),
        FlatButton(
          child: Text("Save",
            style: TextStyle(
              color: Color(0xff66CCCC),
              fontSize: 25,
            )
          ),
          onPressed:  () {saveData();},
        )
      ]
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text("Save Workout",
          style: TextStyle(
            fontSize: 25,
          )
        ),
      ),
      content: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            Text("You are about to end the workout, would you like to save it?",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200
              )
            ),
            buttons,
          ],
        ),
      ),
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

  void rightButtonPressed() {
    setState(() {  
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
        showAlertDialog(context);
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  Widget buttons(String text, VoidCallback callback){
    user = Provider.of<FirebaseUser>(context);  
    return OutlineButton(
      highlightElevation: 20,
      borderSide: BorderSide(
        color: Colors.black
      ),
      child: Text(text, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300, color: Colors.black)),
      onPressed: callback, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TimerText(dependencies: dependencies),
          Text("Elapsed Time",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w100),
          ),
          Padding(
            padding:EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttons(dependencies.stopwatch.isRunning ? "End" : "Start", rightButtonPressed),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimerPage2 extends StatefulWidget {
  TimerPage2({Key key,}) : super(key: key);
  TimerPage2State createState() => new TimerPage2State();
}

class TimerPage2State extends State<TimerPage2> {
  
  final Dependencies dependencies = new Dependencies();

  int _start = 3;
  int _current = 3;
  bool _visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      _visible = false;
      sub.cancel();
      dependencies.stopwatch.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TimerText(dependencies: dependencies)
        ],
      ),
    );
  }
}


class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() => new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
     milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();

      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          // new RepaintBoundary(
          //   child: new SizedBox(
          //     height: 10.0,
              // child: new MinutesAndSeconds(dependencies: dependencies),
              Row(children: <Widget>[MinutesAndSeconds(dependencies: dependencies),
          Hundreds(dependencies: dependencies),],)
          
          //   ),
          // ),
          // new RepaintBoundary(
          //   child: new SizedBox(
          //     height: 10.0,
          //     child: new Hundreds(dependencies: dependencies),
          //   ),
          // ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: TextStyle(fontSize:85.0),);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: TextStyle(fontSize: 85.0),);
  }
}