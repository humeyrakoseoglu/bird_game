import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'humBird.dart';
import 'main.dart';

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
  bool hasStart = false;
  static double barrierXone = 1.6;
  static double barrierXtwo = barrierXone + 1.5;
  double barrierXthree = barrierXtwo + 1.5;
  int score = 0;
  int highscore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yaxis;
    });
  }

  bool fail() {
    if (barrierXone < 0.2 && barrierXone > -0.2) {
      if (yaxis < -0.3 || yaxis > 0.7) {
        return true;
      }
    }
    if (barrierXtwo < 0.2 && barrierXtwo > -0.2) {
      if (yaxis < -0.8 || yaxis > 0.4) {
        return true;
      }
    }
    if (barrierXthree < 0.2 && barrierXthree > -0.2) {
      if (yaxis < -0.4 || yaxis > 0.7) {
        return true;
      }
    }
    return false;
  }

  void begin() {
    hasStart = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      //math function for fall
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        yaxis = initialHeight - height;
      });
      setState(() {
        if (barrierXone < -2) {
          score++;
          barrierXone += 4.5;
        } else {
          barrierXone -= 0.04;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          score++;

          barrierXtwo += 4.5;
        } else {
          barrierXtwo -= 0.04;
        }
      });
      setState(() {
        if (barrierXthree < -2) {
          score++;

          barrierXthree += 4.5;
        } else {
          barrierXthree -= 0.04;
        }
      });
      if (yaxis > 1 || fail()) {
        timer.cancel();
        hasStart = false;
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Text(
              "GAME OVER",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              FlatButton(
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (score > highscore) {
                    highscore = score;
                  }
                  initState();
                  setState(() {
                    hasStart = false;
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasStart) {
          jump();
        } else {
          begin();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, yaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue[200],
                    child: const HumBird(),
                  ),
                  Container(
                    alignment: const Alignment(-0.1, -0.2),
                    child: hasStart
                        ? const Text(" ")
                        : const Text(
                            "T A P   T O   P LA Y",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 32, 60, 83),
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 250.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXthree, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 100.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXthree, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 100.0,
                    ),
                  ),
                ],
              ),
            ),
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
                      const Text(
                        "Score: ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        score.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Best: ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        highscore.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
