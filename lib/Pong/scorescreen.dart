import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {

  final bool gameHasStarted;
  final enemyScore;
  final playerScore;
  ScoreScreen({required this.gameHasStarted, this.enemyScore, this.playerScore});
  @override
  Widget build(BuildContext context) {
    return gameHasStarted ? Stack(
      children: [
        Container(
          alignment: Alignment(0, 0),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 4,
            color: Colors.grey[700],
          ),
        ),
        Container(
          alignment: Alignment(0, -0.3),
            child: Text(
              enemyScore.toString(),
              style: TextStyle(color: Colors.grey[700], fontSize: 100),
            ),
        ),
        Container(
          alignment: Alignment(0, 0.3),
            child: Text(
              playerScore.toString(),
              style: TextStyle(color: Colors.grey[700], fontSize: 100),
            ),
        ),
      ],
    ) : Container();
  }
}
