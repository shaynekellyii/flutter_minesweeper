import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:provider/provider.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({Key key, this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: height == null
            ? const EdgeInsets.all(32.0)
            : const EdgeInsets.only(),
        child: Consumer<GameModel>(
          builder: (context, model, _) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GameInfoItem(
                    icon: Icon(Icons.timer),
                    text: '${model.currentTime}',
                  ),
                  GameInfoItem(
                    icon: Icon(Icons.filter_tilt_shift),
                    text: '${model.minesRemaining}',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GameInfoItem extends StatelessWidget {
  const GameInfoItem({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: 116.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          icon,
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              text ?? '',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
