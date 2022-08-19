import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget{

  final x;
  final y;
  final thisIsEnemy;
  final brickWidth;

  MyBrick({this.x, this.y, this.brickWidth, this.thisIsEnemy});

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment((2*x + brickWidth)/(2-brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEnemy ? Colors.blue[300] : Colors.red[300],
          height: 20,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}