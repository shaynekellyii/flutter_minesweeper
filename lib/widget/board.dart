import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/header.dart';
import 'package:provider/provider.dart';

class MinesweeperBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: (24.0 * model.cols) + 20.0,
          height: (24.0 * model.rows) + 70.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300], width: 8.0)),
          child: Column(
            children: <Widget>[
              MinesweeperHeader(model: model),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: MinesweeperGrid(model: model),
              ),
              // if (model.hasLost) Text('You lost!'),
              // if (model.hasWon) Text('You won!'),
            ],
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
      height: 24.0 * model.rows,
      width: 24.0 * model.cols,
      child: GridView.count(
        crossAxisCount: model.cols,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(model.rows * model.cols, (i) {
          final x = i ~/ model.rows;
          final y = i % model.rows;
          return Tile(
            model: model.tiles[x][y],
            onClick: () => model.onPressed(x, y),
            onLongPress: () => model.onFlagged(x, y),
          );
        }),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  const Tile({
    Key key,
    @required this.model,
    @required this.onClick,
    @required this.onLongPress,
  })  : assert(model != null && onClick != null && onLongPress != null),
        super(key: key);

  final TileModel model;
  final Function() onClick;
  final Function() onLongPress;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.model.isPressed) {
      if (widget.model.isMine) {
        child = Text('M');
      } else {
        child = widget.model.adjacentMines > 0
            ? Text('${widget.model.adjacentMines}')
            : Container();
      }
    } else if (widget.model.isFlagged) {
      child = Text('F');
    } else {
      child = Container();
    }

    return Container(
      margin: EdgeInsets.all(2.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          onTap: widget.onClick,
          onLongPress: widget.onLongPress,
          child: Material(
            color: widget.model.isPressed || _isHovering
                ? Colors.grey[300]
                : Colors.grey[400],
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
