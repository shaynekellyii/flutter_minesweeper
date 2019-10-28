import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Expected elements', (WidgetTester tester) async {
    final tile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: false,
          isPressed: false,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: tile)));

    expect(find.byType(MouseRegion), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('Pressed mine shows icon', (WidgetTester tester) async {
    final tile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: true,
          isPressed: false,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: tile)));
    expect(find.byIcon(Icons.warning), findsNothing);

    final pressedMineTile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: true,
          isPressed: true,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: pressedMineTile)));
    expect(find.byIcon(Icons.warning), findsOneWidget);
  });

  testWidgets('Pressed clear tile shows adjacent mines',
      (WidgetTester tester) async {
    final tile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: false,
          isPressed: false,
          adjacentMines: 4,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: tile)));
    expect(find.text('4'), findsNothing);

    final pressedTile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: false,
          isPressed: true,
          adjacentMines: 4,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: pressedTile)));
    expect(find.text('4'), findsOneWidget);
  });

  testWidgets('Flagged tile shows flag icon', (WidgetTester tester) async {
    final tile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: false,
          isMine: false,
          isPressed: false,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: tile)));
    expect(find.byIcon(Icons.flag), findsNothing);

    final pressedTile = Tile(
        model: TileModel(
          isExploded: false,
          isFlagged: true,
          isMine: false,
          isPressed: false,
        ),
        onClick: () {},
        onLongPress: () {});
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: pressedTile)));
    expect(find.byIcon(Icons.flag), findsOneWidget);
  });
}
