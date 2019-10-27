import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/strings.dart';
import 'package:flutter_minesweeper/model/models.dart';

class ControlDialog extends StatelessWidget {
  static Future<void> show(BuildContext ctx) async {
    return showDialog<void>(
      context: ctx,
      builder: (context) => ControlDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kControlsDialogTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(kHelpClickTile),
            Text(kHelpHoldTile),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(kClose),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class DifficultyDialog extends StatelessWidget {
  const DifficultyDialog({
    Key key,
    @required this.onDifficultyChanged,
  }) : super(key: key);

  final Function(DifficultyModel) onDifficultyChanged;

  static Future<void> show(
      BuildContext ctx, Function(DifficultyModel) onDifficultyChanged) async {
    return showDialog<void>(
      context: ctx,
      builder: (context) =>
          DifficultyDialog(onDifficultyChanged: onDifficultyChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kDifficulty),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[Text(kWillRestart)]),
      ),
      actions: <Widget>[
        ...DifficultyModel.values.map((difficulty) => FlatButton(
              child: Text(difficulty.name),
              onPressed: () => _setDifficulty(context, difficulty),
            )),
        FlatButton(
          child: Text(kCancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _setDifficulty(BuildContext context, DifficultyModel difficulty) {
    onDifficultyChanged(difficulty);
    Navigator.of(context).pop();
  }
}

class RestartDialog extends StatelessWidget {
  const RestartDialog({Key key, @required this.onRestart}) : super(key: key);

  final Function() onRestart;

  static Future<void> show(BuildContext ctx, Function() onRestart) async {
    return showDialog<void>(
      context: ctx,
      builder: (context) => RestartDialog(onRestart: onRestart),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kRestart),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(kRestartAreYouSure),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(kRestart),
          onPressed: () {
            onRestart();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(kCancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
