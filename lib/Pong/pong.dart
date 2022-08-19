import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_collection/Pong/ball.dart';
import 'package:game_collection/Pong/scorescreen.dart';
import 'dart:async';

import 'brick.dart';
import 'coverscreen.dart';

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  State<Pong> createState() => _PongState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _PongState extends State<Pong> {
  int enemyScore = 0;
  int playerScore = 0;
  double playerX = -0.2;
  double enemyX = -0.2;
  double playerWidth = 0.4;
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  bool gameHasStarted = false;
  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      updateDirection();

      moveBall();

      moveEnemy();

      if(isPlayerDead()){
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }
      if(isEnemyDead()){
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
      });
    }

  void moveEnemy() {
    enemyX = ballX - 0.395;
  }

  void _showDialog(bool enemyDied){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.indigo[800],
          title: Center(
            child: Text(
              enemyDied ? "PLAYER 1 WINS" : "ENEMY WINS",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color:
                      enemyDied ? Colors.red[100] : Colors.blue [100],
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(color: enemyDied ? Colors.red[800] : Colors.blue[800]),
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }
  void resetGame(){
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }
  bool isPlayerDead(){
    if(ballY >= 1){
      return true;
    }

    return false;
  }

  bool isEnemyDead(){
    if(ballY < -0.9){
      return true;
    }
    return false;
  }


  void updateDirection(){
    setState(() {
      //update vertical
    if(ballY >= 0.77 && playerX + playerWidth >= ballX && playerX <= ballX) {
      ballYDirection = direction.UP;
    }
    else if(ballY <= -0.77 && enemyX + playerWidth >= ballX && enemyX <= ballX){
      ballYDirection = direction.DOWN;
    }
    //update horizontal
    if(ballX >= 1) {
      ballXDirection = direction.LEFT;
    }
    else if(ballX <= -1){
      ballXDirection = direction.RIGHT;
    }
    });
  }
  void moveBall(){
    setState(() {
      //vertical movement
      if(ballYDirection == direction.DOWN) {
        ballY += 0.005;
      }
      else if(ballYDirection == direction.UP){
        ballY -= 0.005;
      }

      //horizontal movement
      if(ballXDirection == direction.RIGHT) {
        ballX += 0.005;
      }
      else if(ballXDirection == direction.LEFT){
        ballX -= 0.005;
      }
    });
  }

  void moveLeft(){
    setState(() {
      if(!(playerX <= -1)) {
        playerX -= 0.05;
      }
    });
  }

  void moveRight(){
    setState(() {
      if(!(playerX + playerWidth  >= 1)) {
        playerX += 0.05;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          moveRight();
        } else {
          moveLeft();
        }
      },

      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Stack(
              children: [
                //tap to play
                CoverScreen(
                  gameHasStarted: gameHasStarted,
                ),
                //score
                ScoreScreen(
                  gameHasStarted: gameHasStarted,
                  enemyScore: enemyScore,
                  playerScore: playerScore,
                ),
                //top box

                MyBrick(x: enemyX,
                    y: -0.8,
                    brickWidth: playerWidth,
                    thisIsEnemy: true),

                //bottom box
                MyBrick(x: playerX,
                    y: 0.8,
                    brickWidth: playerWidth,
                    thisIsEnemy: false),

                //ball
                MyBall(x: ballX, y: ballY, gameHasStarted: gameHasStarted,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
