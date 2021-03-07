import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  var height;
  var width;
  String timer = "25:00";
  bool play = false;
  bool volume = true;

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
        CircularPercentIndicator(
          radius: height * 0.35,
          animation: true,
          animationDuration: 1200,
          lineWidth: 15.0,
          percent: 0.5,
          center: new Text(
            "$timer Minutes",
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.yellow,
          progressColor: Colors.red,
        ),
        SizedBox(height: height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              width: 56,
              margin: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.blue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  // TODO
                },
              ),
            ),
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
                    // TODO
                  });
                },
              ),
            ),
            Container(
              height: 56,
              width: 56,
              margin: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.blue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.replay),
                color: Colors.white,
                onPressed: () {
                  // TODO
                },
              ),
            ),
            Container(
              height: 56,
              width: 56,
              margin: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.blue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.remove),
                color: Colors.white,
                onPressed: () {
                  // TODO
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
