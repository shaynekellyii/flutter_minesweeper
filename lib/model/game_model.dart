import 'dart:math';

import 'package:flutter/material.dart';

// Breadth first search directions
const List<List<int>> directions = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1],
];

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
      tile.adjacentMines = _getNumAdjacentMines(x, y);
      if (tile.adjacentMines == 0) {
        _visitAllAdjacentMines(x, y);
      }
    }
    notifyListeners();
  }

  int _getNumAdjacentMines(int x, int y) {
    int adjacent = 0;
    directions.forEach((List<int> dir) {
      final newX = x + dir[0];
      final newY = y + dir[1];
      if (_isInBounds(newX, newY) && tiles[newX][newY].isMine) {
        adjacent++;
      }
    });
    return adjacent;
  }

  void _visitAllAdjacentMines(int x, int y) {
    directions.forEach((List<int> dir) {
      final newX = x + dir[0];
      final newY = y + dir[1];
      if (_isInBounds(newX, newY)) {
        onPressed(newX, newY);
      }
    });
  }

  bool _isInBounds(int x, int y) => x >= 0 && x < rows && y >= 0 && y < cols;

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
  int adjacentMines = 0;

  TileModel({
    @required this.isPressed,
    @required this.isFlagged,
    @required this.isMine,
    this.adjacentMines,
  });
}
