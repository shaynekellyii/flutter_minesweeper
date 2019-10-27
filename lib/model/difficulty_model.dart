import 'package:flutter/material.dart';

///
/// Model class describing the game settings for all user difficulties.
///
@immutable
class DifficultyModel {
  const DifficultyModel._(
    this.name,
    this.rows,
    this.cols,
    this.mines,
  );

  static const List<DifficultyModel> values = [
    const DifficultyModel._('Beginner', 9, 9, 10),
    const DifficultyModel._('Intermediate', 16, 16, 40),
    const DifficultyModel._('Expert', 16, 30, 99),
  ];

  final String name;
  final int rows;
  final int cols;
  final int mines;
}
