import 'package:flutter/material.dart';

///
/// Model class describing the game settings for all user difficulties.
///
@immutable
class Difficulty {
  const Difficulty._(
    this.name,
    this.rows,
    this.cols,
    this.mines,
  );

  static const List<Difficulty> values = [
    const Difficulty._('Beginner', 9, 9, 10),
    const Difficulty._('Intermediate', 16, 16, 40),
    const Difficulty._('Expert', 16, 30, 99),
  ];

  final String name;
  final int rows;
  final int cols;
  final int mines;
}
