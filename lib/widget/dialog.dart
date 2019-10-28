import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/constants.dart';
import 'package:flutter_minesweeper/constants/strings.dart';

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
    @required this.onConfirm,
  }) : super(key: key);

  final Function() onConfirm;

  static Future<void> show(BuildContext ctx, Function() onConfirm) async {
    return showDialog<void>(
      context: ctx,
      builder: (context) => DifficultyDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kChangeDifficulty),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[Text(kChangeDifficultyAreYouSure)]),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(kConfirm),
          onPressed: () {
            onConfirm();
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

class CustomDifficultyDialog extends StatefulWidget {
  const CustomDifficultyDialog({
    Key key,
    @required this.onDifficultyChanged,
  })  : assert(onDifficultyChanged != null),
        super(key: key);

  final Function(String, String, String) onDifficultyChanged;

  static Future<void> show(BuildContext ctx,
      Function(String, String, String) onDifficultyChanged) async {
    return showDialog<void>(
      context: ctx,
      builder: (context) =>
          CustomDifficultyDialog(onDifficultyChanged: onDifficultyChanged),
    );
  }

  @override
  _CustomDifficultyDialogState createState() => _CustomDifficultyDialogState();
}

class _CustomDifficultyDialogState extends State<CustomDifficultyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _formRowKey = GlobalKey<FormFieldState>();
  final _formColKey = GlobalKey<FormFieldState>();
  final _formMineKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kCustomDifficulty),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            CustomDifficultyForm(
              formKey: _formKey,
              formRowKey: _formRowKey,
              formColKey: _formColKey,
              formMineKey: _formMineKey,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(kConfirm),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              widget.onDifficultyChanged(
                _formRowKey.currentState.value as String,
                _formColKey.currentState.value as String,
                _formRowKey.currentState.value as String,
              );
              Navigator.of(context).pop();
            }
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

class CustomDifficultyForm extends StatefulWidget {
  const CustomDifficultyForm({
    Key key,
    @required this.formKey,
    @required this.formRowKey,
    @required this.formColKey,
    @required this.formMineKey,
  })  : assert(formKey != null),
        super(key: key);

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> formRowKey;
  final GlobalKey<FormFieldState> formColKey;
  final GlobalKey<FormFieldState> formMineKey;

  @override
  _CustomDifficultyFormState createState() => _CustomDifficultyFormState();
}

class _CustomDifficultyFormState extends State<CustomDifficultyForm> {
  GlobalKey<FormState> _formKey;
  GlobalKey<FormFieldState> _formRowKey;
  GlobalKey<FormFieldState> _formColKey;
  GlobalKey<FormFieldState> _formMineKey;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
    _formRowKey = widget.formRowKey;
    _formColKey = widget.formColKey;
    _formMineKey = widget.formMineKey;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _formRowKey,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: kRows),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the number of rows';
              }
              final int rows = int.tryParse(value);
              if (rows == null || rows < 1) {
                return 'Please enter a valid number';
              } else if (rows >= kMaxRowsCols) {
                return 'Please enter less than $kMaxRowsCols';
              } else if (rows <= kMinRowsCols) {
                return 'Please enter more than $kMinRowsCols';
              }
              return null;
            },
          ),
          TextFormField(
            key: _formColKey,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: kColumns),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the number of columns';
              }
              final int cols = int.tryParse(value);
              if (cols == null || cols < 1) {
                return 'Please enter a valid number';
              } else if (cols <= kMinRowsCols) {
                return 'Please enter more than $kMinRowsCols';
              } else if (cols >= kMaxRowsCols) {
                return 'Please enter less than $kMaxRowsCols';
              }
              return null;
            },
          ),
          TextFormField(
            key: _formMineKey,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: kMines),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the number of mines';
              }

              final int mines = int.tryParse(value);
              if (mines == null || mines < 1) {
                return 'Please enter a valid number';
              }

              final int rows = int.tryParse(
                  (_formRowKey.currentState.value as String) ?? '');
              final int cols = int.tryParse(
                  (_formRowKey.currentState.value as String) ?? '');
              if (rows == null || cols == null) return null;

              final maxMines = (rows * cols - kTileBuffer);
              if (mines >= maxMines) {
                return 'Too many mines! (max $maxMines)';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
