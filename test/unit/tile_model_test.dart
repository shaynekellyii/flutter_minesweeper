import 'package:flutter_minesweeper/model/models.dart';
import 'package:test/test.dart';

void main() {
  test('Values are set correctly', () {
    final model = TileModel(
      isPressed: true,
      isFlagged: false,
      isMine: true,
      isExploded: false,
      adjacentMines: 79,
    );
    expect(model.isPressed, true);
    expect(model.isFlagged, false);
    expect(model.isMine, true);
    expect(model.isExploded, false);
    expect(model.adjacentMines, 79);
  });

  test('Default value for adjacent mines', () {
    final model = TileModel(
      isPressed: true,
      isFlagged: false,
      isMine: true,
      isExploded: false,
    );
    expect(model.adjacentMines, 0);
  });
}
