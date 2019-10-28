import 'package:flutter_minesweeper/model/models.dart';
import 'package:test/test.dart';

void main() {
  test('Initial state', () {
    final model = GameModel();
    expect(model.rows, 9);
    expect(model.cols, 9);
    expect(model.totalTiles, 81);

    expect(model.flagsPlaced, 0);
    expect(model.minesRemaining, 10);

    expect(model.hasWon, false);
    expect(model.hasLost, false);

    expect(model.tiles.length, 9);
    model.tiles.forEach((list) => expect(list.length, 9));

    model.tiles.forEach((list) => list.forEach((tile) {
      expect(tile.isPressed, false);
      expect(tile.isMine, false);
      expect(tile.isFlagged, false);
      expect(tile.isExploded, false);
    }));

    expect(model.currentTime, 0);
    expect(model.difficulty, DifficultyModel.values[0]);
    expect(model.highScores.isEmpty, true);
  });
}