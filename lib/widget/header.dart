import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';

class MinesweeperHeader extends StatelessWidget {
  const MinesweeperHeader({Key key, this.model}) : super(key: key);

  final GameModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MineCounter(count: model.minesRemaining),
          NewGameButton(onTap: model.restart),
          MineCounter(count: model.flagsPlaced),
        ],
      ),
    );
  }
}

class MineCounter extends StatelessWidget {
  const MineCounter({
    Key key,
    @required this.count,
  })  : assert(count != null),
        super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 50.0,
        color: Colors.black,
        child: Center(
          child: Text(
            count.toString(),
            style: TextStyle(color: Colors.red, fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({Key key, @required this.onTap})
      : assert(onTap != null),
        super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 40.0,
          height: 40.0,
          color: Colors.grey[500],
          child: Center(child: Text(':)')),
        ),
      ),
    );
  }
}
