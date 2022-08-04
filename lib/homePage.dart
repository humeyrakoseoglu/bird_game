import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'humBird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double yaxis = 0;
  double time = 0;
  double initialHeight = 0;
  double height = yaxis;
  bool Hasstart = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yaxis;
    });
  }

  void begin() {
    Hasstart = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      //math function for fall
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        yaxis = initialHeight - height;
      });
      if (yaxis > 1) {
        timer.cancel();
        Hasstart = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  if (Hasstart) {
                    jump();
                  } else {
                    begin();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, yaxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.blue[200],
                  child: HumBird(),
                ),
              )),
          Container(
            height: 15,
            color: Colors.green[300],
          ),
          Expanded(
              child: Container(
            color: Colors.brown[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score: ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Best: ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
