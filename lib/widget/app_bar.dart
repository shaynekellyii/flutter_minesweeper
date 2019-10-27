import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/dialog.dart';

class MinesweeperAppBar extends StatelessWidget {
  const MinesweeperAppBar({Key key, @required this.model}) : super(key: key);

  final GameModel model;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_getTitleString(model)),
      actions: <Widget>[
        AppBarAction(
          icon: const Icon(Icons.equalizer),
          onPressed: () => DifficultyDialog.show(
              context, (difficulty) => model.difficulty = difficulty),
          title: const AppBarActionText('Difficulty'),
        ),
        AppBarAction(
          icon: const Icon(Icons.gamepad),
          onPressed: () => ControlDialog.show(context),
          title: const AppBarActionText('Controls'),
        ),
        AppBarAction(
          icon: const Icon(Icons.refresh),
          onPressed: () => RestartDialog.show(context, () => model.restart()),
          title: const AppBarActionText('Restart'),
        ),
      ],
    );
  }

  String _getTitleString(GameModel model) {
    if (model.hasWon) {
      return 'You won!  😀👏🏼';
    } else if (model.hasLost) {
      return 'You lost!  😭';
    }
    return 'Minesweeper  💣';
  }
}

class AppBarActionText extends StatelessWidget {
  const AppBarActionText(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text ?? '',
        style: TextStyle(fontSize: 18.0),
      );
}

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    Key key,
    @required this.icon,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Widget title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          icon,
          Padding(padding: const EdgeInsets.only(left: 8.0), child: title),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
