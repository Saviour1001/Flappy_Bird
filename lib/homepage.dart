import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;

  bool gameHasStarted = false;
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      setState(() {
        if (barrierXOne < -1.1) {
          barrierXOne += 2.2;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -1.1) {
          barrierXTwo += 2.2;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
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
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(" ")
                          : Text(
                              "Tap To Play!!",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXOne, 1.1),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXOne, -2),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXTwo, 1.1),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(barrierXTwo, -2),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Score",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "0",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best Score",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "10",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
