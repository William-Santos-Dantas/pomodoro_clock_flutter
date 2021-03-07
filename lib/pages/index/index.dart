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
  int minutes = 1;
  String timer = "25:00";
  bool play = false;
  bool volume = true;
  int totalSeconds;
  int displayMinutes;
  String displaySeconds;

  @override
  void initState() {
    super.initState();
    totalSeconds = minutes * 60;
    displayMinutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    if (seconds < 10) {
      displaySeconds = ("0$seconds");
    } else {
      displaySeconds = seconds.toString();
    }
  }

  void playTimer() {
    int totalSecondsPlay = totalSeconds;
    Timer.periodic(new Duration(seconds: 1), (timer) {
      //if(totalSeconds == 0) timer.cancel();
      setState(() {
        totalSecondsPlay -= 1;
        displayMinutes = totalSecondsPlay ~/ 60;
        int seconds = totalSecondsPlay % 60;
        if (seconds < 10) {
          displaySeconds = ("0$seconds");
        } else {
          displaySeconds = seconds.toString();
        }
      });
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
            icons(Icons.add),
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
                    if(play) playTimer();
                  });
                },
              ),
            ),
            icons(Icons.replay),
            icons(Icons.remove),
          ],
        )
      ],
    );
  }

  Widget progressIndicator() {
    return CircularPercentIndicator(
      radius: height * 0.35,
      animation: true,
      animationDuration: 1200,
      lineWidth: 15.0,
      percent: 0.5,
      center: new Text(
        "$displayMinutes:$displaySeconds Minutes",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.yellow,
      progressColor: Colors.red,
    );
  }

  Widget icons(IconData icon) {
    return Container(
      height: 56,
      width: 56,
      margin: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: () {
          // TODO
        },
      ),
    );
  }
}
