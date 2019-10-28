import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Expected elements', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MinesweeperProvider(
        child: Scaffold(
          body: MinesweeperBoard(),
        ),
      ),
    ));

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(Tile), findsNWidgets(81));
  });
}
