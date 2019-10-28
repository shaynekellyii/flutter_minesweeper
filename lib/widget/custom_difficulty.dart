import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/strings.dart';
import 'package:flutter_minesweeper/util/validators.dart';

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
                _formMineKey.currentState.value as String,
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
            validator: kRowColValidator,
          ),
          TextFormField(
            key: _formColKey,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: kColumns),
            validator: kRowColValidator,
          ),
          TextFormField(
            key: _formMineKey,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: kMines),
            validator: (value) => kMineValidator(
              value,
              _formRowKey.currentState.value as String,
              _formColKey.currentState.value as String,
            ),
          ),
        ],
      ),
    );
  }
}
