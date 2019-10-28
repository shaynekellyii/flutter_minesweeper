import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/widget/app_bar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Expected elements', (WidgetTester tester) async {
    final appbar =
        MinesweeperAppBar(gameModel: GameModel(), themeModel: ThemeModel());
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          child: appbar,
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
      ),
    ));
    expect(find.text('Minesweeper  💣'), findsOneWidget);
    expect(find.byIcon(Icons.equalizer), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.byIcon(Icons.brightness_3), findsOneWidget);
    expect(find.byIcon(Icons.gamepad), findsOneWidget);
  });
}
