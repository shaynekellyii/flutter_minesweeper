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

  bool _hasWon = false;
  bool _hasLost = false;

  List<List<TileModel>> tiles = <List<TileModel>>[];

  int get rows => _rows;
  int get cols => _cols;

  /// Total tiles to display on the game board.
  int get totalTiles => _rows * _cols;

  /// Number of mines remaining
  int get minesRemaining => _mines - _flagged;

  /// Number of flags placed
  int get flagsPlaced => _flagged;

  bool get hasWon => _hasWon;
  bool get hasLost => _hasLost;

  ///
  /// Recalculate state when a tile is pressed.
  ///
  void onPressed(int x, int y) {
    final tile = tiles[x][y];

    if (tile.isPressed) {
      return;
    } else if (tile.isMine) {
      _hasLost = true;
      tile.isPressed = true;
    } else {
      tile.isPressed = true;
    }
    notifyListeners();
  }

  void _generateTiles() {
    final List<Set> mines = List.generate(_rows, (_) => <int>{});

    // Place mines randomly
    var numMines = 0;
    final rand = Random();
    while (numMines < _mines) {
      int x = rand.nextInt(_rows);
      int y = rand.nextInt(_cols);
      if (!mines[x].contains(y)) {
        mines[x].add(y);
        numMines++;
      }
    }

    tiles = List.generate(
      _rows,
      (x) => List.generate(
        _cols,
        (y) => TileModel(
          isPressed: false,
          isMine: mines[x].contains(y),
          isFlagged: false,
        ),
      ),
    );
    notifyListeners();
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
