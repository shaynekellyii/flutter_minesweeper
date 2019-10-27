import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/tile.dart';

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
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
      ),
    );
  }
}