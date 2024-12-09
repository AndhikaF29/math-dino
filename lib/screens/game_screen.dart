import 'package:flutter/material.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static double dinoYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = dinoYaxis;
  bool gameHasStarted = false;
  
  void jump() {
    setState(() {
      time = 0;
      initialHeight = dinoYaxis;
    });
  }
  
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.5 * time;
      
      setState(() {
        dinoYaxis = initialHeight - height;
      });
      
      if (dinoYaxis > 0) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Container(
          color: Colors.grey[300],
          child: AnimatedContainer(
            alignment: Alignment(0, dinoYaxis),
            duration: const Duration(milliseconds: 0),
            child: const DinoCharacter(),
          ),
        ),
      ),
    );
  }
}

class DinoCharacter extends StatelessWidget {
  const DinoCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.blue, // Ganti dengan gambar dino
    );
  }
} 