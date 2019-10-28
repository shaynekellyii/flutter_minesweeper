import 'package:flutter/foundation.dart';

class TileModel {
  bool isPressed;
  bool isFlagged;
  bool isMine;
  bool isExploded;
  int adjacentMines;

  TileModel({
    @required this.isPressed,
    @required this.isFlagged,
    @required this.isMine,
    @required this.isExploded,
    this.adjacentMines = 0,
  });
}