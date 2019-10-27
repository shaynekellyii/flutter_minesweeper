import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';
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
          home: ChangeNotifierProvider.value(
            value: GameModel(),
            child: MinesweeperScaffold(themeModel: themeModel),
          ),
        ),
      ),
    );
  }
}
