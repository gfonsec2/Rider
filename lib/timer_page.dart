import 'package:flutter/material.dart';
import 'dart:async';

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
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = new Dependencies();

  void leftButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsedMilliseconds}");
      } else {
        dependencies.stopwatch.reset();
      }
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  // Widget buildFloatingButton(String text, VoidCallback callback) {
  //   TextStyle roundTextStyle = const TextStyle(fontSize: 8.0, color: Colors.white);
  //   return new FloatingActionButton(
  //     child: new Text(text, style: roundTextStyle),
  //     onPressed: callback);
  // }

  Widget buttons(String text, VoidCallback callback)
  {
    return OutlineButton(
      highlightElevation: 20,
      borderSide: BorderSide(
      color: Colors.black
      ),
      child: new Text(text, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300, color: Colors.black)),
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
              // buttons(dependencies.stopwatch.isRunning ? "Pause" : "Start", rightButtonPressed),
              // button(dependencies.stopwatch.isRunning ? "Pause" : "Start", rightButtonPressed),
              buttons("Reset", leftButtonPressed),
              buttons(dependencies.stopwatch.isRunning ? "Pause" : "Start", rightButtonPressed),
              ],
            ),
          )
        

        // buildFloatingButton(dependencies.stopwatch.isRunning ? "lap" : "reset", leftButtonPressed),
        // buildFloatingButton(dependencies.stopwatch.isRunning ? "stop" : "start", rightButtonPressed),

      ],
      ),
    );
    // return new Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     new Expanded(
    //       child: new TimerText(dependencies: dependencies),
    //     ),
    //     new Expanded(
    //       flex: 0,
    //       child:  Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             buildFloatingButton(dependencies.stopwatch.isRunning ? "lap" : "reset", leftButtonPressed),
    //             buildFloatingButton(dependencies.stopwatch.isRunning ? "stop" : "start", rightButtonPressed),
    //           ],
    //         ),
    //     ),
    //   ],
    // );
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
    return new Text('$minutesStr:$secondsStr.', style: TextStyle(fontSize: 90.0),);
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
    return new Text(hundredsStr, style: TextStyle(fontSize: 90.0),);
  }
}