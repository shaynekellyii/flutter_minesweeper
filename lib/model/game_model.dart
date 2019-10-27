import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/constants.dart';
import 'package:flutter_minesweeper/model/difficulty.dart';
import 'package:flutter_minesweeper/model/tile.dart';

///
/// Model for the Minesweeper screen.
/// Has [ChangeNotifer] mixin to rebuild the screen when state changes.
///
class GameModel with ChangeNotifier {
  GameModel() {
    _resetTiles();
  }

  // True when mines need to be placed (e.g. when starting a new game).
  bool _shouldRegenerateMines = true;

  // By default, start at beginner level.
  int _rows = 9;
  int _cols = 9;
  int _mines = 10;

  /// Number of tile rows to display on the game board.
  int get rows => _rows;
  /// Number of tile columns to display on the game board.
  int get cols => _cols;
  /// Total tiles to display on the game board.
  int get totalTiles => _rows * _cols;


  /// Number of flags placed
  int get flagsPlaced => _flagged;
  int _flagged = 0;

  /// Number of mines remaining
  int get minesRemaining => _mines - _flagged;

  int _improperlyFlagged = 0;

  bool get hasWon => _hasWon;
  bool _hasWon = false;
  bool get hasLost => _hasLost;
  bool _hasLost = false;


  /// 
  /// List of lists of tiles to be accessed by Cartesian coordinates 
  /// i.e. tiles[x][y]
  /// 
  List<List<TileModel>> get tiles => _tiles;
  List<List<TileModel>> _tiles;

  /// Current time in seconds that the game has been running.
  int get currentTime => _currentTime;
  int _currentTime = 0;
  Timer _timer;

  /// The current game difficulty. Set to beginner by default.
  Difficulty get difficulty => _difficulty;
  Difficulty _difficulty = Difficulty.values[0];
  set difficulty(Difficulty newDifficulty) {
    _rows = newDifficulty.rows;
    _cols = newDifficulty.cols;
    _mines = newDifficulty.mines;
    restart();
  }

  ///
  /// Recalculate state when a tile is pressed.
  /// Presses will be ignored when the game is over.
  /// 
  /// Mines will be placed and timer will be started if this is the first tile 
  /// pressed of the current game.
  /// 
  /// Notifies [Widget] listeners that they should rebuild after state is 
  /// recalculated.
  ///
  void onPressed(int x, int y) {
    if (_hasWon || _hasLost) return;
    if (_shouldRegenerateMines) _placeMines(x, y);

    final tile = _tiles[x][y];

    if (_timer == null || !_timer.isActive) _startTimer();

    if (tile.isPressed || tile.isFlagged) {
      return;
    } else if (tile.isMine) {
      _endGame(false, losingTile: <int>[x, y]);
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
  /// Notifies [Widget] listeners that they should rebuild after state is 
  /// recalculated.
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

  void _endGame(bool hasWon, {List<int> losingTile}) {
    _hasWon = hasWon;
    _hasLost = !hasWon;
    _revealAllTiles(losingTile);
    _timer.cancel();
  }

  void _revealAllTiles(List<int> losingTile) {
    _tiles
        .asMap()
        .forEach((rowIndex, row) => row.asMap().forEach((colIndex, tile) {
              if (!tile.isFlagged) {
                tile.isPressed = true;
                tile.isExploded = losingTile != null &&
                    losingTile[0] == rowIndex &&
                    losingTile[1] == colIndex;
                tile.adjacentMines = _getNumAdjacentMines(rowIndex, colIndex);
              }
            }));
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
          isExploded: false,
        ),
      )
    );
    notifyListeners();
  }

  // The seedX and seedY coordinates are used to make sure that no mine is 
  // placed on the clicked tile or any adjacent tile.
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
          isExploded: false,
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
      const Duration(seconds: 1),
      (timer) {
        _currentTime = timer.tick;
        notifyListeners();
      },
    );
  }
}
