import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key key,
    @required this.model,
    @required this.onClick,
    @required this.onLongPress,
    this.isGameOver = false,
  })  : assert(model != null && onClick != null && onLongPress != null),
        super(key: key);

  final TileModel model;
  final Function() onClick;
  final Function() onLongPress;
  final bool isGameOver;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
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
              color: _getBackgroundColor(),
              child: SizedBox(
                height: 24.0,
                width: 24.0,
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) =>
                        _getTileContent(constraints),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTileContent(BoxConstraints constraints) {
    final iconSize = constraints.biggest.height - 1.0;

    Widget child;
    if (widget.model.isPressed) {
      if (widget.model.isMine) {
        child = Icon(Icons.filter_tilt_shift, size: iconSize);
      } else {
        child = widget.model.adjacentMines > 0
            ? Text('${widget.model.adjacentMines}')
            : Container();
      }
    } else if (widget.model.isFlagged) {
      if (!widget.model.isMine && widget.isGameOver) {
        child = Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Icon(Icons.filter_tilt_shift, size: iconSize),
            ),
            Icon(Icons.close, size: iconSize + 1.0, color: Colors.red),
          ],
        );
      } else {
        child = Icon(Icons.flag, color: Colors.red, size: iconSize);
      }
    } else {
      child = Container();
    }
    return child;
  }

  Color _getBackgroundColor() {
    if (widget.model.isExploded) return Colors.red;

    bool isLightMode = Theme.of(context).brightness == Brightness.light;
    bool isLighter =
        widget.model.isPressed || (_isHovering && !widget.model.isFlagged);
    if (isLighter) return isLightMode ? Colors.grey[300] : Colors.black45;

    return isLightMode ? Colors.grey[400] : Colors.black;
  }
}
