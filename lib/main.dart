import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/scaffold.dart';
import 'package:provider/provider.dart';

void main() => runApp(MinesweeperApp());

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minesweeper',
      theme: ThemeData(
        fontFamily: 'Dosis',
        primaryColor: Colors.grey[300],
      ),
      home: ChangeNotifierProvider.value(
        value: GameModel(),
        child: MinesweeperScaffold(),
      ),
    );
  }
}
