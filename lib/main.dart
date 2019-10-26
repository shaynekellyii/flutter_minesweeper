import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/board.dart';
import 'package:flutter_minesweeper/widget/dialog.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minesweeper',
      theme: ThemeData(
        fontFamily: 'Dosis',
        primaryColor: Colors.grey[300],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minesweeper'),
          centerTitle: true,
          actions: <Widget>[
            ControlButton(),
          ],
        ),
        body: MinesweeperScreen(),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.gamepad),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('Controls'),
          )
        ],
      ),
      onPressed: () => ControlDialog.show(context),
    );
  }
}

class MinesweeperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ChangeNotifierProvider.value(
                value: GameModel(),
                child: MinesweeperBoard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
