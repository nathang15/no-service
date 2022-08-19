// @dart=2.9
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:game_collection/Tetris/block.dart';
import 'sub_block.dart';

enum Collision { LANDED, LANDED_BLOCK, HIT_WALL, HIT_BLOCK, NONE }

const blockX = 10;
const blockY = 20;
const REFRESH_RATE = 300;
const GAME_AREA_BORDER_WIDTH = 2.0;
const SUB_BLOCK_EDGE_WIDTH = 2.0;

class Game extends StatefulWidget {
  Game({Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() => GameState();
}


class GameState extends State<Game> {
  bool isGameOver = false;
  double subBlockWidth = 0;
  Duration duration =  Duration(milliseconds: REFRESH_RATE);
  GlobalKey _keyGameArea = GlobalKey();

  BlockMovement action;
  Block block;
  Timer timer;
  bool isPlaying = false;
  int score;

  List<SubBlock> oldSubBlocks;

  Block getNewBlock() {
    int blockType = Random().nextInt(7);
    int orientationIndex = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return IBlock(orientationIndex);
      case 1:
        return JBlock(orientationIndex);
      case 2:
        return LBlock(orientationIndex);
      case 3:
        return OBlock(orientationIndex);
      case 4:
        return TBlock(orientationIndex);
      case 5:
        return SBlock(orientationIndex);
      case 6:
        return ZBlock(orientationIndex);
      default:
        return null;
    }
  }



  void startGame(){
    isPlaying = true;
    score = 0;
    isGameOver = false;

    oldSubBlocks = List<SubBlock>();

    RenderBox renderBoxGame = _keyGameArea.currentContext.findRenderObject();
    subBlockWidth = (renderBoxGame.size.width - GAME_AREA_BORDER_WIDTH * 2) / blockX;

    block = getNewBlock();

    timer = Timer.periodic(duration, onPlay);
  }

  void updateScore(){
    var combo = 1;
    Map<int, int> rows = Map();
    List<int> rowsToBeRemoved = List();

    oldSubBlocks?.forEach((subBlock) {
      rows.update(subBlock.y, (value) => ++value, ifAbsent: () => 1);
    });

    //Add Score
    rows.forEach((rowNum, count){
      if (count == blockX){
        score += combo++;
        print('score: $score');
        rowsToBeRemoved.add(rowNum);
      }
    });

    if(rowsToBeRemoved.length>0){
      removeRows(rowsToBeRemoved);
    }
  }


  void removeRows(List<int> rowsToBeRemoved){
    rowsToBeRemoved.sort();
    rowsToBeRemoved.forEach((rowNum){
      oldSubBlocks.removeWhere((subBlock) => subBlock.y == rowNum);
      oldSubBlocks.forEach((subBlock) {
        if(subBlock.y < rowNum){
          ++subBlock.y;
        }
      });
    });
  }

  void endGame(){
    isPlaying = false;
    timer.cancel();
  }

  void onPlay(Timer timer){
    var status = Collision.NONE;

    setState(() {
      if(action != null){
        if(!checkEdge(action)){
          block.move(action);
        }
      }

      for(var oldSubBlock in oldSubBlocks){
        for(var subBlock in block.subBlocks){
          var x = block.x + subBlock.x;
          var y = block.y + subBlock.y;
          if(x == oldSubBlock.x && y == oldSubBlock.y){
            switch(action){
              case BlockMovement.LEFT:
                block.move(BlockMovement.RIGHT);
                break;
              case BlockMovement.RIGHT:
                block.move(BlockMovement.LEFT);
                break;
              case BlockMovement.ROTATE_CLOCKWISE:
                block.move(BlockMovement.ROTATE_COUNTER_CLOCKWISE);
                break;
              default:
                break;
            }
          }
        }
      }

      if(!checkAtBottom()){
        if(!checkAtAbove()){
          block.move(BlockMovement.DOWN);
        }
        else{
          status = Collision.LANDED_BLOCK;
        }
      }
      else{
        status = Collision.LANDED;
      }

      if(status == Collision.LANDED_BLOCK && block.y < 0){
        isGameOver = true;
        endGame();
      }

      else if(status == Collision.LANDED || status == Collision.LANDED_BLOCK){
        block.subBlocks.forEach((subBlock){
          subBlock.x += block.x;
          subBlock.y += block.y;
          oldSubBlocks.add(subBlock);
        });
        block = getNewBlock();
      }
      action = null;
      updateScore();
    });
  }

  bool checkAtBottom(){
    return block.y + block.height == blockY;
  }

  bool checkAtAbove() {
    for (var oldSubBlock in oldSubBlocks) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;
        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkEdge(BlockMovement action){
    return(action == BlockMovement.LEFT && block.x <= 0) ||
        (action == BlockMovement.RIGHT && block.x + block.width >= blockX);
  }

  Widget getGameOverBox(){
    return Positioned(
      child: Container(
        width: subBlockWidth * 8,
        height: subBlockWidth * 3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Text(
          'GAME OVER',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      left: subBlockWidth,
      top: subBlockWidth * 6
    );
  }

  Widget getPositionedSquareContainer(Color color, int x, int y){
    return Positioned(
      left: x * subBlockWidth,
      top: y * subBlockWidth,
      child: Container(
        width: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        height: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(const Radius.circular(3)),
        ),
      )
    );
  }

  Widget drawBlock(){
    if(block == null) return null;
    List<Positioned> subBlocks = List();

    block.subBlocks.forEach((subBlock) {
      subBlocks.add(getPositionedSquareContainer(
          subBlock.color, subBlock.x + block.x, subBlock.y + block.y));
    });

    oldSubBlocks?.forEach((oldSubBlock) {
      subBlocks.add(getPositionedSquareContainer(
          oldSubBlock.color, oldSubBlock.x, oldSubBlock.y
      ));
    });

    if (isGameOver){
      subBlocks.add(getGameOverBox());
    }

    return Stack(children: subBlocks,);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details){
        if(details.delta.dx > 0){
          action = BlockMovement.RIGHT;
        }
        else{
          action = BlockMovement.LEFT;
        }
      },

      onTap: (){
        action = BlockMovement.ROTATE_CLOCKWISE;
      },

      child: AspectRatio(
        aspectRatio: blockX / blockY,
        child: Container(
          key: _keyGameArea,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            border: Border.all(
              width: 4,
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: drawBlock(),
        ),
      ),
    );


  }
}

