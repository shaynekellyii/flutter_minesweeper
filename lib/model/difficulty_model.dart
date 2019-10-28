import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/strings.dart';

///
/// Model class describing the game settings for all user difficulties.
///
@immutable
class DifficultyModel extends Comparable {
  DifficultyModel(this.name, this.rows, this.cols, this.mines, this.level);

  DifficultyModel.empty()
      : name = 'Custom',
        rows = 0,
        cols = 0,
        mines = 0,
        level = 3;

  DifficultyModel.custom(this.cols, this.rows, this.mines)
      : level = 3,
        name = 'Custom';

  static List<DifficultyModel> values = [
    DifficultyModel(kBeginner, 9, 9, 10, 0),
    DifficultyModel(kIntermediate, 16, 16, 40, 1),
    DifficultyModel(kExpert, 16, 30, 99, 2),
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
