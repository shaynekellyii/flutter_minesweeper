import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/strings.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/util/view_util.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';

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
          title: kControls,
        ),
        DifficultyAction(gameModel: gameModel),
        AppBarAction(
          icon: Icon(
              themeModel.isLight ? Icons.brightness_3 : Icons.brightness_5),
          onPressed: () => themeModel.isLight = !themeModel.isLight,
          title: themeModel.isLight ? kDark : kLight,
        ),
        AppBarAction(
          icon: const Icon(Icons.refresh),
          onPressed: () => _onRestartPressed(context),
          title: kRestart,
        ),
      ],
    );
  }

  void _onRestartPressed(BuildContext context) {
    final restart = () => gameModel.restart();
    if (!(gameModel.hasWon || gameModel.hasLost)) {
      RestartDialog.show(context, restart);
    } else {
      restart();
    }
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
      return kYouWon;
    } else if (gameModel.hasLost) {
      return kYouLost;
    }
    return kAppTitle;
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
  final String title;
  final Function() onPressed;

  Widget _buildDesktopWidget() {
    return FlatButton(
      child: Row(
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: AppBarActionText(title),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildMobileWidget() =>
      IconButton(icon: icon, onPressed: onPressed, tooltip: title);

  @override
  Widget build(BuildContext context) =>
      isMobile(context) ? _buildMobileWidget() : _buildDesktopWidget();
}

class DifficultyAction extends StatelessWidget {
  const DifficultyAction({
    Key key,
    @required this.gameModel,
  }) : super(key: key);

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    final emptyCustomDifficulty = DifficultyModel.empty();

    return PopupMenuButton<DifficultyModel>(
      child: isMobile(context) ? _buildMobileWidget() : _buildDesktopWidget(),
      tooltip: kDifficulty,
      onSelected: (difficulty) => _onDifficultySelected(difficulty, context),
      itemBuilder: (BuildContext context) => [
        ...DifficultyModel.values
            .map<PopupMenuItem<DifficultyModel>>(
                (diff) => PopupMenuItem<DifficultyModel>(
                      value: diff,
                      child: Text(diff.name),
                    ))
            .toList(),
        PopupMenuItem<DifficultyModel>(
          value: emptyCustomDifficulty,
          child: Text(emptyCustomDifficulty.name),
        ),
      ],
    );
  }

  void _onDifficultySelected(DifficultyModel difficulty, BuildContext context) {
    if (gameModel.difficulty == difficulty) {
      final snackbar = ThemedSnackbar(
        title: 'You are already playing in ${difficulty.name} mode',
      ) as SnackBar;
      Scaffold.of(context).showSnackBar(snackbar);
    } else if (difficulty.level == 3) {
      CustomDifficultyDialog.show(context,
          (String rows, String cols, String mines) {
        gameModel.difficulty = DifficultyModel.custom(
            int.parse(cols), int.parse(rows), int.parse(mines));
      });
    } else {
      DifficultyDialog.show(context, () => gameModel.difficulty = difficulty);
    }
  }

  Widget _buildMobileWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(Icons.equalizer),
    );
  }

  Widget _buildDesktopWidget() {
    return Row(
      children: <Widget>[
        Icon(Icons.equalizer),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: AppBarActionText(kDifficulty),
        ),
      ],
    );
  }
}
