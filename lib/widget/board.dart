import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/header.dart';
import 'package:provider/provider.dart';

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
    return Consumer<GameModel>(
      builder: (context, model, child) => Container(
        height: 24.0 * model.rows,
        width: 24.0 * model.cols,
        child: GridView.count(
          crossAxisCount: model.cols,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(model.tiles.length, (i) {
            return Tile(model: model.tiles[i]);
          }),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({Key key, @required this.model})
      : assert(model != null),
        super(key: key);

  final TileModel model;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (model.isPressed) {
      child = Text('R');
    } else if (model.isFlagged) {
      child = Text('F');
    } else {
      child = Container();
    }

    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: model.isPressed ? Colors.grey[200] : Colors.grey[300],
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(child: child),
    );
  }
}
