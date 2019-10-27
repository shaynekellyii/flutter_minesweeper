import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/board.dart';
import 'package:flutter_minesweeper/widget/dialog.dart';
import 'package:flutter_minesweeper/widget/game_info.dart';
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
      home: ChangeNotifierProvider.value(
        value: GameModel(),
        child: MinesweeperScaffold(),
      ),
    );
  }
}

class MinesweeperScaffold extends StatelessWidget {
  const MinesweeperScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_getTitleString(model)),
            actions: <Widget>[
              ToolbarButton(
                icon: Icon(Icons.gamepad),
                onPressed: () => ControlDialog.show(context),
                title: Text('Controls', style: TextStyle(fontSize: 18.0)),
              ),
              ToolbarButton(
                icon: Icon(Icons.refresh),
                onPressed: () =>
                    RestartDialog.show(context, () => model.restart()),
                title: Text('Restart', style: TextStyle(fontSize: 18.0)),
              ),
            ],
          ),
          body: MinesweeperScreen(),
        );
      },
    );
  }

  String _getTitleString(GameModel model) {
    if (model.hasWon) {
      return 'You won!  😀👏🏼';
    } else if (model.hasLost) {
      return 'You lost!  😭';
    }
    return 'Minesweeper  💣';
  }
}

class ToolbarButton extends StatelessWidget {
  const ToolbarButton({
    Key key,
    @required this.icon,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final Widget title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          icon,
          Padding(padding: const EdgeInsets.only(left: 8.0), child: title),
        ],
      ),
      onPressed: onPressed,
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
              MinesweeperBoard(),
              GameInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
