import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/util/view_util.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';
import 'package:provider/provider.dart';

class MinesweeperBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            child: Container(
              width: getTilePixelDimension(context) * model.cols + 16.0,
              height: getTilePixelDimension(context) * model.rows + 16.0,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  MinesweeperGrid(model: model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// Beginner: 9x9, 10 mines
///
class MinesweeperGrid extends StatelessWidget {
  const MinesweeperGrid({Key key, @required this.model}) : super(key: key);

  final GameModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getTilePixelDimension(context) * model.rows,
      width: getTilePixelDimension(context) * model.cols,
      child: GridView.count(
        crossAxisCount: model.cols,
        physics: NeverScrollableScrollPhysics(),
        children: generateChildren(model),
      ),
    );
  }

  List<Widget> generateChildren(GameModel model) {
    return List.generate(
      model.rows,
      (x) => List.generate(
        model.cols,
        (y) => Tile(
          model: model.tiles[x][y],
          onClick: () => model.onPressed(x, y),
          onLongPress: () => model.onFlagged(x, y),
        ),
      ),
    ).expand((e) => e).toList();
  }
}
