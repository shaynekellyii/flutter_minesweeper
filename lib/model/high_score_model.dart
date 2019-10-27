import 'package:flutter/foundation.dart';

@immutable
class HighScoreModel {
  const HighScoreModel({
    @required this.difficulty,
    @required this.time,
  }) : assert(difficulty != null && time != null);

  final String difficulty;
  final int time;
}
