import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/dialog.dart';
import 'package:flutter_minesweeper/widget/theme.dart';

class MinesweeperAppBar extends StatelessWidget {
  const MinesweeperAppBar({
    Key key,
    @required this.gameModel,
    @required this.themeModel,
  }) : super(key: key);

  final GameModel gameModel;
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _getAppBarColor(context),
      title: Text(_getTitleString()),
      actions: <Widget>[
        AppBarAction(
          icon: const Icon(Icons.gamepad),
          onPressed: () => ControlDialog.show(context),
          title: const AppBarActionText('Controls'),
        ),
        AppBarAction(
          icon: const Icon(Icons.equalizer),
          onPressed: () => DifficultyDialog.show(
              context, (difficulty) => gameModel.difficulty = difficulty),
          title: const AppBarActionText('Difficulty'),
        ),
        AppBarAction(
          icon: Icon(
              themeModel.isLight ? Icons.brightness_3 : Icons.brightness_5),
          onPressed: () => themeModel.isLight = !themeModel.isLight,
          title: AppBarActionText(themeModel.isLight ? 'Dark' : 'Light'),
        ),
        AppBarAction(
          icon: const Icon(Icons.refresh),
          onPressed: () =>
              RestartDialog.show(context, () => gameModel.restart()),
          title: const AppBarActionText('Restart'),
        ),
      ],
    );
  }

  Color _getAppBarColor(BuildContext context) {
    if (gameModel.hasWon) {
      return Colors.green[800];
    } else if (gameModel.hasLost) {
      return Colors.red[800];
    } 
    return Theme.of(context).appBarTheme.color;
  }

  String _getTitleString() {
    if (gameModel.hasWon) {
      return 'You won!  😀👏🏼';
    } else if (gameModel.hasLost) {
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
