import 'package:flutter/material.dart';
import 'package:game_collection/Wordle/wordle.dart';
import 'Pong/pong.dart';
import 'Snake/snake.dart';
import 'Tetris/tetris.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _controller = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          Wordle(),
          Pong(),
          Tetris(),
          SnakeGame(),
        ],
      ),
    );
  }
}