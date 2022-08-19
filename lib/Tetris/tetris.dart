// @dart=2.9
import 'package:flutter/material.dart';
import 'package:game_collection/Tetris/game.dart';
import 'package:game_collection/Tetris/scorescreen.dart';
import 'package:game_collection/Tetris/upcomingBlock.dart';

void main() {runApp(const MaterialApp(home: Tetris() ,));}

class Tetris extends StatefulWidget {
  const Tetris({Key key}) : super(key: key);

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  GlobalKey<GameState> _keyGame = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T E T R I S'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ScoreScreen(),
            Expanded(
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                            child: Game(key: _keyGame),
                          ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30),
                              RaisedButton(
                                child: Text(
                                  _keyGame.currentState != null && _keyGame.currentState.isPlaying?
                                  'End' : 'Start',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[200],
                                  ),
                                ),
                                color: Colors.grey[700],
                                onPressed: () {

                                  _keyGame.currentState != null && _keyGame.currentState.isPlaying?
                                        _keyGame.currentState.endGame() :
                                        _keyGame.currentState.startGame();

                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }
}
