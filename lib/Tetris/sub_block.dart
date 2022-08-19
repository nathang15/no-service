import 'package:flutter/material.dart';

class SubBlock {
  int x = 0;
  int y = 0;
  Color color = Colors.white;
  SubBlock(int x, int y, [Color color = Colors.transparent]) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}