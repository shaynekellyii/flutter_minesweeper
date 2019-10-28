import 'package:flutter_minesweeper/model/high_score_model.dart';
import 'package:test/test.dart';

void main() {
  test('Values are set correctly', () {
    final model = HighScoreModel(difficulty: 'difficult', time: 27);
    expect(model.difficulty, 'difficult');
    expect(model.time, 27);
  });

  test('Null values not allowed', () {
    expect(() => HighScoreModel(difficulty: null, time: 0),
        throwsA(TypeMatcher<AssertionError>()));
    expect(() => HighScoreModel(difficulty: 'a', time: null),
        throwsA(TypeMatcher<AssertionError>()));
  });
}
