import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/game_model.dart';
import 'package:flutter_minesweeper/widget/app_bar.dart';
import 'package:flutter_minesweeper/widget/board.dart';
import 'package:flutter_minesweeper/widget/game_info.dart';
import 'package:provider/provider.dart';

class MinesweeperScaffold extends StatelessWidget {
  const MinesweeperScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: PreferredSize(
            child: MinesweeperAppBar(model: model),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          body: const MinesweeperBody(),
        );
      },
    );
  }
}

class MinesweeperBody extends StatelessWidget {
  const MinesweeperBody({Key key}) : super(key: key);
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
