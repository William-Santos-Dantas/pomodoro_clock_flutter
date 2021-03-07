import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  var height;
  var width;
  int minutes = 25;
  String text = "Minutos";
  String timer = "25:00";
  bool play = false;
  bool volume = true;
  int totalSeconds;
  int displayMinutes;
  String displaySeconds;
  int currentTime;
  double progressbar = 0;
  var interval;

  @override
  void initState() {
    super.initState();
    totalSeconds = minutes * 60;
    displayMinutes = totalSeconds ~/ 60;
    currentTime = totalSeconds;
    int seconds = totalSeconds % 60;
    if (seconds < 10) {
      displaySeconds = ("0$seconds");
    } else {
      displaySeconds = seconds.toString();
    }
  }

  void playTimer() {
    interval = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        progressbar += 1 / totalSeconds;
        if (progressbar > 1) progressbar = 1;
        currentTime -= 1;
        displayMinutes = currentTime ~/ 60;
        int seconds = currentTime % 60;
        if (displayMinutes > 1) {
          text = "Minutos";
        } else if (displayMinutes == 1) {
          text = "Minuto";
        } else {
          text = "Segundos";
        }
        if (seconds < 10) {
          displaySeconds = "0$seconds";
        } else {
          displaySeconds = seconds.toString();
        }
      });
      if (currentTime == 0) {
        progressbar = 1;
        play = false;
        timer.cancel();
      }
    });
  }

  void less() {
    interval.cancel();
    minutes -= 1;
    totalSeconds = minutes * 60;
    setState(() {
      currentTime = totalSeconds;
      progressbar = 0;
      displayMinutes = currentTime ~/ 60;
      displaySeconds = "0${currentTime % 60}";
      text = "Minutos";
    });
  }

  void stop() {
    interval.cancel();
  }

  void more() {
    interval.cancel();
    minutes += 1;
    totalSeconds = minutes * 60;
    setState(() {
      currentTime = totalSeconds;
      progressbar = 0;
      displayMinutes = currentTime ~/ 60;
      displaySeconds = "0${currentTime % 60}";
      text = "Minutos";
    });
  }

  void reset() {
    interval.cancel();
    totalSeconds = minutes * 60;
    setState(() {
      currentTime = totalSeconds;
      progressbar = 0;
      displayMinutes = currentTime ~/ 60;
      displaySeconds = "0${currentTime % 60}";
      text = "Minutos";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration: ShapeDecoration(
            color: volume ? Colors.blue : Colors.red,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(volume ? Icons.volume_up : Icons.volume_off),
            color: Colors.white,
            onPressed: () {
              setState(() {
                volume = !volume;
              });
              // TODO
            },
          ),
        ),
      ], elevation: 0, backgroundColor: Colors.transparent),
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressIndicator(),
        SizedBox(height: height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icons(Icons.add, more),
            Container(
              height: 56,
              width: 56,
              margin: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: play ? Colors.red : Colors.blue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(play ? Icons.pause : Icons.play_arrow),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    play = !play;
                    play ? playTimer() : stop();
                  });
                },
              ),
            ),
            icons(Icons.replay, reset),
            icons(Icons.remove, less),
          ],
        )
      ],
    );
  }

  Widget progressIndicator() {
    return CircularPercentIndicator(
      radius: height * 0.35,
      animation: false,
      lineWidth: 15.0,
      percent: progressbar,
      center: new Text(
        "$displayMinutes:$displaySeconds $text",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.yellow,
      progressColor: Colors.red,
    );
  }

  Widget icons(IconData icon, Function function) {
    return Container(
      height: 56,
      width: 56,
      margin: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: IconButton(
          icon: Icon(icon), color: Colors.white, onPressed: function),
    );
  }
}
