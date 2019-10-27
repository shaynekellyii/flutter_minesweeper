import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:provider/provider.dart';

class MinesweeperProvider extends StatelessWidget {
  const MinesweeperProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameModel>.value(value: GameModel()),
        ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
      ],
      child: child,
    );
  }
}
