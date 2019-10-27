import 'package:flutter/foundation.dart';

class TileModel {
  bool isPressed;
  bool isFlagged;
  bool isMine;
  int adjacentMines = 0;

  TileModel({
    @required this.isPressed,
    @required this.isFlagged,
    @required this.isMine,
    this.adjacentMines,
  });
}