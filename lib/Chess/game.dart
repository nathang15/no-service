import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int row = 8;

  int totalNumberOfSquares = 64;

  bool thisPieceIsSelected = false;

  int indexOfCurrentlySelectedPiece = -1;

  String colorOfCurrentSelectedPiece = 'white';

  String currentlySelectedPiece = '';


  var deadWhitePieces = [];
  var deadBlackPieces = [];
  bool whiteTurn = true;

  List<int> blackSquares = []

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

