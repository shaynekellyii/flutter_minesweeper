import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/scaffold.dart';
import 'package:flutter_minesweeper/widget/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MinesweeperApp());

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Minesweeper',
          theme: themeModel.theme,
          darkTheme: ThemeData.dark(),
          home: ChangeNotifierProvider.value(
            value: GameModel(),
            child: MinesweeperScaffold(themeModel: themeModel),
          ),
        ),
      ),
    );
  }
}
