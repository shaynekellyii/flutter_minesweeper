import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key key, this.time = 0}) : super(key: key);

  final int time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.timer),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('$time'),
        ),
      ],
    );
  }
}
