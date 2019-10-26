import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/widget/header.dart';

class MinesweeperBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300], width: 8.0)),
        child: Column(
          children: <Widget>[
            MinesweeperHeader(),
            MinesweeperGrid(),
          ],
        ),
      ),
    );
  }
}

///
/// Beginner: 9x9, 10 mines
///
class MinesweeperGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0 * 9.0,
      width: 24.0 * 9.0,
      child: GridView.count(
        crossAxisCount: 9,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(9 * 9, (i) {
          return Tile(
            isFlagged: i % 2 == 0,
            isRevealed: i % 1 == 1,
            value: i % 4,
          );
        }),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key key,
    @required this.value,
    @required this.isRevealed,
    @required this.isFlagged,
  })  : assert(value != null && isRevealed != null && isFlagged != null),
        super(key: key);

  final int value;
  final bool isRevealed;
  final bool isFlagged;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isRevealed && value > 0) {
      child = Text('$value');
    } else if (isFlagged) {
      child = Text('F');
    } else {
      child = Container();
    }

    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: isRevealed ? Colors.grey[200] : Colors.grey[300],
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(child: child),
    );
  }
}
