
import 'package:flutter/material.dart';

class MinesweeperHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MineCounter(count: 99),
          NewGameButton(),
          MineCounter(count: 0),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        color: Colors.grey[500],
        child: Center(child: Text(':)')),
      ),
    );
  }
}
