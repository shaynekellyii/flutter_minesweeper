import 'dart:math';

import 'package:flutter/material.dart';

class GameModel with ChangeNotifier {
  GameModel() {
    _generateTiles();
  }

  ///
  /// Internal state
  /// For now, hardcoded to 9x9 with 10 mines.
  ///
  int _rows = 9;
  int _cols = 9;
  int _mines = 10;
  int _flagged = 0;
  int _improperlyFlagged = 0;

  List<TileModel> tiles = [];

  int get rows => _rows;
  int get cols => _cols;

  /// Total tiles to display on the game board.
  int get totalTiles => _rows * _cols;

  /// Number of mines remaining
  int get minesRemaining => _mines - _flagged;

  /// Number of flags placed
  int get flagsPlaced => _flagged;

  ///
  /// Recalculate state when a tile is pressed.
  ///
  void onPressed(int index) {
    
  }

  void _generateTiles() {
    final mines = <int>{};
    final rand = Random();
    while (mines.length < _mines) {
      mines.add(rand.nextInt(_rows * _cols));
    }

    tiles = List.generate(
      9 * 9,
      (index) => TileModel(
        isFlagged: false,
        isPressed: false,
        isMine: mines.contains(index),
      ),
    );
  }
}

class TileModel {
  bool isPressed;
  bool isFlagged;
  bool isMine;

  TileModel({
    @required this.isPressed,
    @required this.isFlagged,
    @required this.isMine,
  });
}
