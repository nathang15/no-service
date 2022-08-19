
import 'package:flutter/material.dart';
import 'sub_block.dart';


enum BlockMovement {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  ROTATE_CLOCKWISE,
  ROTATE_COUNTER_CLOCKWISE
}

class Block {
  //List<List<SubBlock>> orientations = List<List<SubBlock>>();
  List orientations = List.filled(7, List<SubBlock>);
  int x = 0;
  int y = 0;
  int orientationIndex;

  Block(this.orientations, Color color, this.orientationIndex) {
    x = 3;
    y = -height;
    this.color = color;
  }

  set color(Color color) {
    orientations.forEach((orientation) {
      orientation.forEach((subBlock) {
        subBlock.color = color;
      });
    });
  }

  Color getColor() {
    return orientations[0][0].color;
  }

  get subBlocks {
    return orientations[orientationIndex];
  }

  get width {
    int maxX = 0;
    subBlocks.forEach((subBlock){
      if (subBlock.x > maxX) maxX = subBlock.x;
    });
    return maxX + 1;
  }

  get height {
    int maxY = 0;
    subBlocks.forEach((subBlock){
      if (subBlock.y > maxY) maxY = subBlock.y;
    });
    return maxY + 1;
  }

  void move(BlockMovement blockMovement) {
    switch (blockMovement) {
      case BlockMovement.UP:
        y -= 1;
        break;
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.ROTATE_CLOCKWISE:
        orientationIndex = ++orientationIndex % 4;
        break;
      case BlockMovement.ROTATE_COUNTER_CLOCKWISE:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}

class IBlock extends Block {
  IBlock(int orientationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
  ], Colors.red.shade500, orientationIndex);
}

class JBlock extends Block {
  JBlock(int orientationIndex)
      : super([
    [SubBlock(1, 0), SubBlock(1, 1), SubBlock(1, 2), SubBlock(0, 2)],
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(0, 2)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(2, 1)],
  ], Colors.yellow.shade500, orientationIndex);
}

class LBlock extends Block {
  LBlock(int orientationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(1, 2)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(1, 2)],
    [SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
  ], Colors.green.shade500, orientationIndex);
}

class OBlock extends Block {
  OBlock(int orientationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
  ], Colors.blue.shade500, orientationIndex);
}

class TBlock extends Block {
  TBlock(int orientationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(1, 1)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
  ], Colors.teal.shade500, orientationIndex);
}

class SBlock extends Block {
  SBlock(int orientationIndex)
      : super([
    [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
    [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
  ], Colors.orange.shade500, orientationIndex);
}

class ZBlock extends Block {
  ZBlock(int orientationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
  ], Colors.cyan.shade500, orientationIndex);
}