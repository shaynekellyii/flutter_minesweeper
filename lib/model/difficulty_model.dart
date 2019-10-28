import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/strings.dart';

///
/// Model class describing the game settings for all user difficulties.
///
@immutable
class DifficultyModel extends Comparable {
  DifficultyModel._(
    this.name,
    this.rows,
    this.cols,
    this.mines,
    this.level,
  );

  static List<DifficultyModel> values = [
    DifficultyModel._(kBeginner, 9, 9, 10, 0),
    DifficultyModel._(kIntermediate, 16, 16, 40, 1),
    DifficultyModel._(kExpert, 16, 30, 99, 2),
  ];

  final String name;
  final int rows;
  final int cols;
  final int mines;
  final int level;

  @override
  int compareTo(other) =>
      this.level.compareTo((other as DifficultyModel).level);
}
