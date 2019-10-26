import 'package:flutter/material.dart';

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
      title: Text('Controls 🕹'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('⛏ Click on a tile to reveal what\'s below'),
            Text('🚩 Click and hold a tile to flag it'),
            Text('🙂 Click the smiley face to restart'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
