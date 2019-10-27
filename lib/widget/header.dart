import 'package:flutter/material.dart';

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
