import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/constants.dart';
import 'package:flutter_minesweeper/model/difficulty.dart';
import 'package:flutter_minesweeper/model/tile.dart';

class GameModel with ChangeNotifier {
  GameModel() {
    _resetTiles();
  }

  bool _shouldRegenerateMines = true;

  int _rows = 9;
  int _cols = 9;
  int _mines = 10;

  int get rows => _rows;
  int get cols => _cols;

  /// Total tiles to display on the game board.
  int get totalTiles => _rows * _cols;

  int _flagged = 0;

  /// Number of flags placed
  int get flagsPlaced => _flagged;

  /// Number of mines remaining
  int get minesRemaining => _mines - _flagged;

  int _improperlyFlagged = 0;

  bool _hasWon = false;
  bool _hasLost = false;
  bool get hasWon => _hasWon;
  bool get hasLost => _hasLost;

  List<List<TileModel>> _tiles;

  /// Tiles to be accessed by Cartesian coordinates i.e. tiles[x][y]
  List<List<TileModel>> get tiles => _tiles;

  Timer _timer;
  int _currentTime = 0;

  /// Current time in seconds that the game has been running.
  int get currentTime => _currentTime;

  Difficulty _difficulty = Difficulty.values[0];
  Difficulty get difficulty => _difficulty;
  set difficulty(Difficulty newDifficulty) {
    _rows = newDifficulty.rows;
    _cols = newDifficulty.cols;
    _mines = newDifficulty.mines;
    restart();
  }

  ///
  /// Recalculate state when a tile is pressed.
  ///
  void onPressed(int x, int y) {
    if (_hasWon || _hasLost) return;
    if (_shouldRegenerateMines) _placeMines(x, y);

    final tile = _tiles[x][y];

    if (_timer == null || !_timer.isActive) _startTimer();

    if (tile.isPressed || tile.isFlagged) {
      return;
    } else if (tile.isMine) {
      _endGame(false);
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

  ///
  /// Updates the state after marking a tile as flagged.
  ///
  void onFlagged(int x, int y) {
    final tile = _tiles[x][y];

    if (_shouldRegenerateMines || tile.isPressed) return;

    if (tile.isFlagged) {
      _flagged--;
      if (!tile.isMine) _improperlyFlagged--;
    } else {
      _flagged++;
      if (!tile.isMine) _improperlyFlagged++;
    }
    tile.isFlagged = !tile.isFlagged;

    // Check for winner
    if (_improperlyFlagged == 0 && _flagged == _mines) {
      _endGame(true);
    }

    notifyListeners();
  }

  ///
  /// Resets the game to initial conditions.
  ///
  void restart() {
    _flagged = 0;
    _improperlyFlagged = 0;
    _hasWon = false;
    _hasLost = false;

    _timer?.cancel();
    _currentTime = 0;

    _resetTiles();
    _shouldRegenerateMines = true;
    notifyListeners();
  }

  void _endGame(bool hasWon) {
    _hasWon = hasWon;
    _hasLost = !hasWon;
    _timer.cancel();
  }

  int _getNumAdjacentMines(int x, int y) {
    int adjacent = 0;
    kBfsDirections.forEach((List<int> dir) {
      final newX = x + dir[0];
      final newY = y + dir[1];
      if (_isInBounds(newX, newY) && _tiles[newX][newY].isMine) {
        adjacent++;
      }
    });
    return adjacent;
  }

  List<Set<int>> _getAdjacentMines(int x, int y) {
    final adjacent = List.generate(_rows, (_) => <int>{});
    kBfsDirections.forEach((List<int> dir) {
      final newX = x + dir[0];
      final newY = y + dir[1];
      if (_isInBounds(newX, newY)) {
        adjacent[newX].add(y);
      }
    });
    return adjacent;
  }

  void _visitAllAdjacentMines(int x, int y) {
    kBfsDirections.forEach((List<int> dir) {
      final newX = x + dir[0];
      final newY = y + dir[1];
      if (_isInBounds(newX, newY)) {
        onPressed(newX, newY);
      }
    });
  }

  bool _isInBounds(int x, int y) => x >= 0 && x < rows && y >= 0 && y < cols;

  void _resetTiles() {
    _tiles = List.generate(
      _rows,
      (x) => List.generate(
        _cols,
        (y) => TileModel(
          isPressed: false,
          isMine: false,
          isFlagged: false,
        ),
      ),
    );
    notifyListeners();
  }

  void _placeMines(int seedX, int seedY) {
    final List<Set> mines = List.generate(_rows, (_) => <int>{});

    var numMines = 0;
    final rand = Random();
    while (numMines < _mines) {
      int x = rand.nextInt(_rows);
      int y = rand.nextInt(_cols);
      if (!(mines[x].contains(y) || _isInSafeZone(x, y, seedX, seedY))) {
        mines[x].add(y);
        numMines++;
      }
    }

    _tiles = List.generate(
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
    _shouldRegenerateMines = false;
    notifyListeners();
  }

  bool _isInSafeZone(int x, int y, int safeX, int safeY) =>
      (x - safeX).abs() <= 1 && (y - safeY).abs() <= 1;

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _currentTime = timer.tick;
        notifyListeners();
      },
    );
  }
}
