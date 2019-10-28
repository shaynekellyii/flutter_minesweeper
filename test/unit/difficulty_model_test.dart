import 'package:flutter_minesweeper/model/difficulty_model.dart';
import 'package:test/test.dart';

void main() {
  test('Values are set correctly', () {
    final model = DifficultyModel('name', 5, 7, 12, 14);
    expect(model.name, equals('name'));
    expect(model.rows, equals(5));
    expect(model.cols, equals(7));
    expect(model.mines, equals(12));
    expect(model.level, equals(14));
  });

  test('Empty model', () {
    final model = DifficultyModel.empty();
    expect(model.name, equals('Custom'));
    expect(model.rows, equals(0));
    expect(model.cols, equals(0));
    expect(model.mines, equals(0));
    expect(model.level, equals(3));
  }); 

  test('Default values', () {
    expect(DifficultyModel.values.length, 3);
  });

  test('Custom comparator', () {
    final easyModel = DifficultyModel.values[0];
    final hardModel = DifficultyModel.values[2];
    final customModel = DifficultyModel.empty();
    expect(easyModel.compareTo(easyModel), 0);
    expect(easyModel.compareTo(hardModel), -1);
    expect(customModel.compareTo(hardModel), 1);
    expect(customModel.compareTo(customModel), 0);
  });
}