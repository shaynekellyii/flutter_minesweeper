import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>.value(
      value: ThemeModel(),
      child: child,
    );
  }
}
